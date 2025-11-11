<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Comment;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    public function index(Request $request){
        $maHotel = $request->query('maHotel');
        $maBlog = $request->query('maBlog');

        $query = Comment::query();

        if ($maHotel) {
            $query->where('maHotel', $maHotel);
        }

        if ($maBlog) {
            $query->where('maBlog', $maBlog);
        }

       $comments = $query->whereNull('parent_id')->with('replies')->orderBy('created_at', 'desc')->get();

        return response()->json([
            'status' => 200,
            'data' => $comments
        ], 200);
    }

    public function store(Request $request){
        $validated = $request->validate([
            'parent_id' => 'nullable|exists:comments,id',
            'comment' => 'required|string|max:1000',
            'maHotel' => 'nullable|exists:hotels,id',
            'maBlog' => 'nullable',
            'rating'    => 'nullable|integer|min:1|max:5',
        ]);

        $user = Auth::user();
        $validated['userId'] = $user->id;
        $validated['userName'] = $user->name;
        $validated['userAvatar'] = $user->image ?? null;
        if (!empty($validated['parent_id'])) {
            $parent = Comment::find($validated['parent_id']);
            $validated['level'] = $parent ? $parent->level + 1 : 1;
        } else {
            $validated['level'] = 0;
        }
        $validated['time']=now();
        $comment = Comment::create($validated);
        return response()->json([
            'status' => 201,
            'data' => $comment,
            'message' => 'Comment created successfully'
        ], 201);
    }
}
