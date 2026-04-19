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
            [
                'hm_id' => $hotel->user_id ?? null,
                'status' => 'open',
                'last_message' => null,
                'hm_unread_count' => 0,
                'hm_last_read_at' => null,
            ]
        );

        return response()->json(['status' => 200, 'thread' => $thread]);
    }

    public function getMessages(Request $request, $threadId)
    {
        $user = $request->user();

        $thread = HotelChatThread::find($threadId);
        if (!$thread) {
            return response()->json(['status' => 404, 'message' => 'Thread not found'], 404);
        }

        if ($thread->user_id !== $user->id && $thread->hm_id !== $user->id && (int)$user->role !== 1) {
            return response()->json(['status' => 403, 'message' => 'Forbidden'], 403);
        }

        $perPage = max(20, min((int) $request->query('per_page', 40), 100));
        $page = max(1, (int) $request->query('page', 1));

        $messagesQuery = $thread->messages()->orderBy('created_at', 'desc');
        $messagesPaginator = $messagesQuery->paginate($perPage, ['*'], 'page', $page);

        if ((int) $user->role === 2 && $thread->hm_id === $user->id && (int) $thread->hm_unread_count > 0) {
            $thread->update([
                'hm_unread_count' => 0,
                'hm_last_read_at' => now(),
            ]);
        }

        return response()->json([
            'status' => 200,
            'thread' => $thread,
            'messages' => $messagesPaginator->getCollection()->reverse()->values(),
            'pagination' => [
                'current_page' => $messagesPaginator->currentPage(),
                'last_page' => $messagesPaginator->lastPage(),
                'per_page' => $messagesPaginator->perPage(),
                'has_more' => $messagesPaginator->hasMorePages(),
            ],
        ]);
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
            ->get()
            ->map(function ($thread) {
                $thread->hotel_group = $thread->hotel?->name ? mb_strtoupper(mb_substr($thread->hotel->name, 0, 1)) : 'H';
                return $thread;
            });

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

        $threadUpdate = [
            'last_message' => $content,
            'status' => 'open',
        ];

        if ((int) $user->role === 2) {
            $threadUpdate['hm_last_read_at'] = now();
        } else {
            $threadUpdate['hm_unread_count'] = ((int) $thread->hm_unread_count) + 1;
        }

        $thread->update($threadUpdate);

        try {
            // Broadcast cho thread (room chat hiện tại)
            broadcast(new HotelChatMessageSent($thread, $message))->toOthers();

            // Broadcast cho manager (để update sidebar/danh sách chat)
            if ($thread->hm_id) {
                broadcast(new HotelChatMessageSent($thread, $message));
            }
        } catch (\Exception $e) {
            Log::error('HotelChat broadcast error: '. $e->getMessage());
        }

        return response()->json([ 'status' => 201, 'message' => 'Sent', 'data' => $message ]);
    }
}
