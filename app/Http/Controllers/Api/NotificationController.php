<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use App\Models\Subscriber;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class NotificationController extends Controller
{
     public function index(Request $request)
    {
        $userId = Auth::id();
        $notifications = Notification::where('user_id', $userId)
                                     ->orderBy('created_at', 'desc')
                                     ->get();

        return response()->json([
            'status' => 'success',
            'notifications' => $notifications
        ]);
    }

    // Mark 1 notification as read
    public function markAsRead(Request $request, $id)
    {
        $userId = Auth::id();
        $notification = Notification::where('id', $id)
                                    ->where('user_id', $userId)
                                    ->firstOrFail();

        $notification->update(['is_read' => true]);

        return response()->json([
            'status' => 'success',
            'message' => 'Notification marked as read'
        ]);
    }

    // Mark all notifications as read
    public function markAllAsRead(Request $request)
    {
        $userId = Auth::id();
        Notification::where('user_id', $userId)
                    ->where('is_read', false)
                    ->update(['is_read' => true]);

        return response()->json([
            'status' => 'success',
            'message' => 'All notifications marked as read'
        ]);
    }
}
