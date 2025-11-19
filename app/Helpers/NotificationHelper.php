<?php

namespace App\Helpers;

use App\Events\NotificationSuccess;
use App\Models\Notification;
use App\Events\PaymentSuccess;

class NotificationHelper
{
    /**
     * Tạo notification và broadcast realtime
     */
    public static function send($userId, $type, $title, $message)
    {
        $notification = Notification::create([
            'user_id' => $userId,
            'type' => $type,
            'title' => $title,
            'message' => $message,
        ]);

        // Broadcast event theo loại
        switch ($type) {
            case 'payment':
                broadcast(new NotificationSuccess($notification));
                break;
            // có thể thêm các case khác: cancel, refund, promotion...
        }

        return $notification;
    }
}
