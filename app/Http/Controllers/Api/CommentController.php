<?php

namespace App\Http\Controllers\Api;

use App\Helpers\NotificationHelper;
use App\Http\Controllers\Controller;
use App\Models\Comment;
use App\Models\Hotel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CommentController extends Controller
{
    public function index(Request $request)
    {
        $maHotel = $request->query('maHotel');
        $maBlog  = $request->query('maBlog');

        $query = Comment::query();

        if ($maHotel) {
            $query->where('maHotel', $maHotel);
        }

        if ($maBlog) {
            $query->where('maBlog', $maBlog);
        }

        $comments = $query->whereNull('parent_id')
            ->with('replies')
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'status' => 200,
            'data'   => $comments
        ], 200);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'parent_id' => 'nullable|exists:comments,id',
            'comment'   => 'required|string|max:1000',
            'maHotel'   => 'nullable|exists:hotels,id',
            'maBlog'    => 'nullable',
            'rating'    => 'nullable|integer|min:1|max:5',
        ]);

        $user = Auth::user();
        $validated['userId']     = $user->id;
        $validated['userName']   = $user->name;
        $validated['userAvatar'] = $user->image ?? null;

        if (!empty($validated['parent_id'])) {
            $parent            = Comment::find($validated['parent_id']);
            $validated['level'] = $parent ? $parent->level + 1 : 1;
        } else {
            $validated['level'] = 0;
        }

        $validated['time'] = now();
        $comment = Comment::create($validated);

        // 🔵 Notify HOTEL MANAGER: có review/comment mới
        if (!empty($validated['maHotel'])) {
            // Dùng withoutGlobalScopes() để tìm hotel kể cả khi chưa approved
            $hotel = Hotel::withoutGlobalScopes()->find($validated['maHotel']);
            if ($hotel && $hotel->user_id && $hotel->user_id !== $user->id) {
                $ratingText = !empty($validated['rating'])
                    ? " ({$validated['rating']}⭐)"
                    : '';
                NotificationHelper::send(
                    $hotel->user_id,
                    'new_review',
                    '💬 Có đánh giá mới',
                    "{$user->name} vừa để lại đánh giá{$ratingText} cho khách sạn của bạn.",
                    [
                        'hotel_id'   => $validated['maHotel'],
                        'comment_id' => $comment->id,
                        'rating'     => $validated['rating'] ?? null,
                    ]
                );
            }
        }

        return response()->json([
            'status'  => 201,
            'data'    => $comment,
            'message' => 'Comment created successfully'
        ], 201);
    }

    public function update($id, Request $request)
    {
        $comment = Comment::findOrFail($id);
        $user    = Auth::user();

        if ($comment->userId !== $user->id) {
            return response()->json([
                'status'  => 403,
                'message' => 'Bạn không có quyền sửa comment này.'
            ], 403);
        }

        $validated = $request->validate([
            'comment' => 'required|string|max:1000',
            'rating'  => 'nullable|integer|min:1|max:5',
        ]);

        $comment->update($validated);

        return response()->json([
            'status'  => 200,
            'data'    => $comment,
            'message' => 'Cập nhật comment thành công.'
        ]);
    }

    public function destroy($id)
    {
        $comment = Comment::findOrFail($id);
        $user    = Auth::user();

        if ($comment->userId !== $user->id) {
            return response()->json([
                'status'  => 403,
                'message' => 'Bạn không có quyền xóa comment này.'
            ], 403);
        }

        $comment->delete();

        return response()->json([
            'status'  => 200,
            'message' => 'Xóa comment thành công.'
        ]);
    }
}
