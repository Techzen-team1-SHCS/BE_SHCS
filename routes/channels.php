<?php

use Illuminate\Support\Facades\Broadcast;

/*
|--------------------------------------------------------------------------
| Broadcast Channels
|--------------------------------------------------------------------------
*/

// Channel mặc định của Laravel (giữ nguyên)
Broadcast::channel('App.Models.User.{id}', function ($user, $id) {
    \Illuminate\Support\Facades\Log::info("Authorizing broadcast for user: {$user->id} vs requested id: {$id}");
    return (int) $user->id === (int) $id;
});

// Private channel cho từng user nhận notification cá nhân (đã có sẵn)
Broadcast::channel('user.{id}', function ($user, $id) {
    return (int) $user->id === (int) $id;
});

// Private channel cho Hotel Manager — chỉ role=2 mới subscribe được
Broadcast::channel('hotel-manager.{userId}', function ($user, $userId) {
    return (int) $user->id === (int) $userId && (int) $user->role === 2;
});

Broadcast::channel('hotel-chat.{threadId}', function ($user, $threadId) {
    $thread = \App\Models\HotelChatThread::find($threadId);
    if (!$thread) {
        return false;
    }
    return (int) $user->id === (int) $thread->user_id
        || (int) $user->id === (int) $thread->hm_id
        || (int) $user->role === 1;
});

// Private channel cho Admin — chỉ role=1
Broadcast::channel('admin.{userId}', function ($user, $userId) {
    return (int) $user->id === (int) $userId && (int) $user->role === 1;
});
