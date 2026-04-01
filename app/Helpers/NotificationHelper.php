<?php

namespace App\Helpers;

use App\Events\NotificationSuccess;
use App\Models\Notification;

class NotificationHelper
{
    /**
     * Map type → priority tự động
     * Giữ nguyên các type cũ để backward-compatible
     */
    private static array $priorityMap = [
        // 🔴 Critical
        'new_booking'       => 'critical',
        'check_in_today'    => 'critical',
        'check_out_today'   => 'critical',
        'payment_failed'    => 'critical',

        // 🟡 Warning
        'room_low_stock'    => 'warning',
        'booking_cancelled' => 'warning',
        'cancel_booking'    => 'warning',   // type cũ — backward compat

        // 🟢 Success
        'payment_success'   => 'success',
        'payment'           => 'success',   // type cũ — backward compat
        'booking_created'   => 'success',
        'booking'           => 'success',   // type cũ — backward compat
        'booking_confirmed' => 'success',
        'hotel_approved'    => 'success',
        'Registration_Successful' => 'success', // type cũ — backward compat

        // 🔵 Info
        'new_review'           => 'info',
        'user_updated_profile' => 'info',
    ];

    /**
     * Tạo notification và broadcast realtime
     *
     * @param int         $userId   ID người nhận
     * @param string      $type     Loại notification
     * @param string      $title    Tiêu đề
     * @param string      $message  Nội dung
     * @param array|null  $data     Dữ liệu phụ (booking_id, hotel_id, ...)
     * @return Notification
     */
    public static function send($userId, string $type, string $title, string $message, ?array $data = null): Notification
    {
        // Xác định priority: ưu tiên lấy từ $data nếu caller tự truyền
        $priority = $data['priority'] ?? self::$priorityMap[$type] ?? 'info';

        // Lọc priority ra khỏi data để không lưu trùng lặp
        $cleanData = $data;
        if (isset($cleanData['priority'])) {
            unset($cleanData['priority']);
        }

        $notification = Notification::create([
            'user_id'  => $userId,
            'type'     => $type,
            'title'    => $title,
            'message'  => $message,
            'priority' => $priority,
            'data'     => !empty($cleanData) ? $cleanData : null,
            'is_read'  => false,
        ]);

        // Broadcast realtime qua private channel user.{id}
        broadcast(new NotificationSuccess($notification));

        return $notification;
    }
}
