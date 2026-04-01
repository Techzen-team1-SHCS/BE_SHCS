<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class NotificationSuccess implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $notification;

    public function __construct($notification)
    {
        $this->notification = $notification;
    }

    public function broadcastOn()
    {
        return new PrivateChannel('user.' . $this->notification->user_id);
    }

    public function broadcastWith()
    {
        return [
            'id'         => $this->notification->id,
            'type'       => $this->notification->type,
            'priority'   => $this->notification->priority ?? 'info',
            'title'      => $this->notification->title,
            'message'    => $this->notification->message,
            'data'       => $this->notification->data,
            'is_read'    => false,
            'created_at' => $this->notification->created_at->toDateTimeString(),
        ];
    }
}
