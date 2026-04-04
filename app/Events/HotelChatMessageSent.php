<?php

namespace App\Events;

use App\Models\HotelChatMessage;
use App\Models\HotelChatThread;
use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\ShouldBroadcast;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Queue\SerializesModels;

class HotelChatMessageSent implements ShouldBroadcastNow
{
    use InteractsWithSockets, SerializesModels;

    public HotelChatThread $thread;
    public HotelChatMessage $message;

    public function __construct(HotelChatThread $thread, HotelChatMessage $message)
    {
        $this->thread = $thread;
        $this->message = $message;
    }

    public function broadcastOn(): PrivateChannel
    {
        return new PrivateChannel('hotel-chat.' . $this->thread->id);
    }

    public function broadcastWith(): array
    {
        return [
            'thread_id' => $this->thread->id,
            'message' => [
                'id'          => $this->message->id,
                'sender_type' => $this->message->sender_type,
                'sender_id'   => $this->message->sender_id,
                'content'     => $this->message->content,
                'type'        => $this->message->type,
                'created_at'  => $this->message->created_at->toDateTimeString(),
            ],
        ];
    }

    public function broadcastAs(): string
    {
        return 'HotelChatMessageSent';
    }
}
