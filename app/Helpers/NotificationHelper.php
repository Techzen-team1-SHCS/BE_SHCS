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
    public static function send($userId, $type, $title, $message,$data=null)
    {
        $notification = Notification::create([
        'user_id' => $userId,
        'type' => $type,
        'title' => $title,
        'message' => $message,
        'data' => $data ? json_encode($data) : null,
        ]);
        // Broadcast event theo loại
        switch ($type) {
            case 'payment':
                broadcast(new NotificationSuccess($notification));
                break;
            case 'booking':
                broadcast(new NotificationSuccess($notification));
                break;
            case 'cancel_booking':
                broadcast(new NotificationSuccess($notification));
                break;
            case 'Registration Successful':
                broadcast(new NotificationSuccess($notification));
                break;
            default:
                broadcast(new NotificationSuccess($notification));
                break;
        }

        return $notification;
    }
}
