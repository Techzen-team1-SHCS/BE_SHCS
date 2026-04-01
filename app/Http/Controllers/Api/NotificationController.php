<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use App\Models\Subscriber;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class NotificationController extends Controller
{
    /**
     * GET /api/auth/notifications
     * Query params:
     *   - priority : critical | warning | info | success
     *   - type     : new_booking | payment_failed | ...
     *   - unread   : true  → chỉ lấy chưa đọc
     *   - limit    : số item / trang (default 20)
     *   - page     : trang (default 1)
     */
    public function index(Request $request)
    {
        $userId = Auth::id();

        $query = Notification::where('user_id', $userId)
            ->orderBy('created_at', 'desc');

        if ($request->filled('priority')) {
            $query->where('priority', $request->priority);
        }

        if ($request->filled('type')) {
            $query->where('type', $request->type);
        }

        if ($request->boolean('unread')) {
            $query->where('is_read', false);
        }

        $limit         = (int) $request->get('limit', 20);
        $notifications = $query->paginate($limit);

        $unreadCount = Notification::where('user_id', $userId)
            ->where('is_read', false)
            ->count();

        return response()->json([
            'status' => 'success',
            'data'   => $notifications->items(),
            'meta'   => [
                'total'        => $notifications->total(),
                'unread_count' => $unreadCount,
                'current_page' => $notifications->currentPage(),
                'last_page'    => $notifications->lastPage(),
                'per_page'     => $notifications->perPage(),
            ],
        ]);
    }

    /**
     * GET /api/auth/Allnotifications  (Admin — giữ nguyên logic cũ)
     */
    public function getAllAdmin()
    {
        $adminId       = Auth::id();
        $notifications = Notification::where('user_id', $adminId)
            ->orderBy('created_at', 'desc')
            ->get();

        if ($notifications->isEmpty()) {
            return response()->json([
                'status'  => 404,
                'message' => 'Not found notification',
            ]);
        }

        return response()->json([
            'status' => 200,
            'data'   => $notifications,
        ]);
    }

    /**
     * GET /api/auth/notifications/unread-count
     * Endpoint nhẹ — chỉ trả badge count, không load data
     */
    public function unreadCount()
    {
        $count = Notification::where('user_id', Auth::id())
            ->where('is_read', false)
            ->count();

        return response()->json([
            'status'       => 'success',
            'unread_count' => $count,
        ]);
    }

    /**
     * PUT /api/auth/notifications/{id}/read
     */
    public function markAsRead(Request $request, $id)
    {
        $notification = Notification::where('id', $id)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        $notification->update(['is_read' => true]);

        return response()->json([
            'status'  => 'success',
            'message' => 'Notification marked as read',
        ]);
    }

    /**
     * PUT /api/auth/notifications/mark-all-read
     */
    public function markAllAsRead(Request $request)
    {
        Notification::where('user_id', Auth::id())
            ->where('is_read', false)
            ->update(['is_read' => true]);

        return response()->json([
            'status'  => 'success',
            'message' => 'All notifications marked as read',
        ]);
    }

    /**
     * DELETE /api/auth/notifications/{id}
     * Xóa 1 notification (chỉ của chính user)
     */
    public function destroy($id)
    {
        $notification = Notification::where('id', $id)
            ->where('user_id', Auth::id())
            ->firstOrFail();

        $notification->delete();

        return response()->json([
            'status'  => 'success',
            'message' => 'Notification deleted',
        ]);
    }

    /**
     * DELETE /api/auth/notifications/clear-read
     * Xóa tất cả notification đã đọc
     */
    public function clearRead()
    {
        $deleted = Notification::where('user_id', Auth::id())
            ->where('is_read', true)
            ->delete();

        return response()->json([
            'status'  => 'success',
            'message' => "Đã xóa {$deleted} notification đã đọc",
        ]);
    }

    /**
     * POST /api/auth/subscriber — giữ nguyên route cũ
     */
    public function store(Request $request)
    {
        $request->validate(['endpoint' => 'required']);
        Subscriber::updateOrCreate(
            ['endpoint' => $request->endpoint],
            $request->only(['endpoint', 'public_key', 'auth_token'])
        );

        return response()->json(['status' => 'success']);
    }
}