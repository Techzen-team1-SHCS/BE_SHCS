<?php

namespace App\Http\Controllers\Api;

use App\Events\HotelChatMessageSent;
use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\HotelChatMessage;
use App\Models\HotelChatThread;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class HotelChatController extends Controller
{
    public function getOrCreateThread(Request $request, $hotelId)
    {
        $user = $request->user();

        $hotel = Hotel::find($hotelId);
        if (!$hotel) {
            return response()->json(['status' => 404, 'message' => 'Hotel not found'], 404);
        }

        $thread = HotelChatThread::firstOrCreate(
            ['hotel_id' => $hotelId, 'user_id' => $user->id],
            ['hm_id' => $hotel->user_id ?? null, 'status' => 'open', 'last_message' => null]
        );

        return response()->json(['status' => 200, 'thread' => $thread]);
    }

    public function getMessages(Request $request, $threadId)
    {
        $user = $request->user();

        $thread = HotelChatThread::with('messages')->find($threadId);
        if (!$thread) {
            return response()->json(['status' => 404, 'message' => 'Thread not found'], 404);
        }

        if ($thread->user_id !== $user->id && $thread->hm_id !== $user->id && (int)$user->role !== 1) {
            return response()->json(['status' => 403, 'message' => 'Forbidden'], 403);
        }

        return response()->json(['status' => 200, 'thread' => $thread, 'messages' => $thread->messages]);
    }

    public function getHMThreads(Request $request)
    {
        $user = $request->user();

        if ((int)$user->role !== 2 && (int)$user->role !== 1) {
            return response()->json(['status' => 403, 'message' => 'Forbidden'], 403);
        }

        $threads = HotelChatThread::with(['hotel', 'user'])
            ->where('hm_id', $user->id)
            ->orderBy('updated_at', 'desc')
            ->get();

        return response()->json(['status' => 200, 'threads' => $threads]);
    }

    public function sendMessage(Request $request, $threadId)
    {
        $user = $request->user();
        $content = trim($request->input('content'));

        if ($content === '') {
            return response()->json(['status' => 400, 'message' => 'Nội dung không được để trống'], 400);
        }

        $thread = HotelChatThread::find($threadId);
        if (!$thread) {
            return response()->json(['status' => 404, 'message' => 'Thread not found'], 404);
        }

        if ($thread->user_id !== $user->id && $thread->hm_id !== $user->id && (int)$user->role !== 1) {
            return response()->json(['status' => 403, 'message' => 'Forbidden'], 403);
        }

        $senderType = $thread->user_id === $user->id ? 'user' : 'hm';

        $message = HotelChatMessage::create([
            'thread_id' => $thread->id,
            'sender_type' => $senderType,
            'sender_id' => $user->id,
            'content' => $content,
            'type' => 'text',
        ]);

        $thread->update([
            'last_message' => $content,
            'status' => 'open',
        ]);

        try {
            broadcast(new HotelChatMessageSent($thread, $message))->toOthers();
        } catch (\Exception $e) {
            Log::error('HotelChat broadcast error: '. $e->getMessage());
        }

        return response()->json([ 'status' => 201, 'message' => 'Sent', 'data' => $message ]);
    }
}
