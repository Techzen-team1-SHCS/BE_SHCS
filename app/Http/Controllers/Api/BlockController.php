<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class BlockController extends Controller
{
    public function blockUser(Request $request, $id)
    {
        $user = \App\Models\User::find($id);
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $user->is_blocked = 1;
        $user->save();

        return response()->json(['message' => 'User blocked successfully'], 200);
    }

    public function unblockUser(Request $request, $id)
    {
        $user = \App\Models\User::find($id);
        if (!$user) {
            return response()->json(['message' => 'User not found'], 404);
        }

        $user->is_blocked = 0;
        $user->save();

        return response()->json(['message' => 'User unblocked successfully'], 200);
    }
}
