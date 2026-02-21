<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\BroadcastMessage;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class HotelPendingApprovalNotification extends Notification implements ShouldQueue
{
    use Queueable;

    /**
     * Create a new notification instance.
     */
    public function __construct(public $hotel)
    {
        //
    }

    /**
     * Get the notification's delivery channels.
     *
     * @return array<int, string>
     */
    public function via($notifiable)
    {
        return ['database','broadcast']; 
    }

    public function toDatabase($notifiable)
    {
        return [
            'hotel_id' => $this->hotel->id,
            'hotel_name' => $this->hotel->name,
            'message' => 'Có khách sạn mới cần duyệt'
        ];
    }

    public function toBroadcast($notifiable)
    {
        return new BroadcastMessage([
            'hotel_id' => $this->hotel->id,
            'hotel_name' => $this->hotel->name,
            'message' => 'Có khách sạn mới cần duyệt'
        ]);
    }
}
