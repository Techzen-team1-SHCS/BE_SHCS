<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class RoomQuantityUpdated implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    /**
     * Create a new event instance.
     */
    public $roomId;
    public $availableQuantity;
    public $action;
    public $bookingId;

    public function __construct($roomId, $availableQuantity, $action, $bookingId = null)
    {
        $this->roomId = $roomId;
        $this->availableQuantity = $availableQuantity;
        $this->action = $action;
        $this->bookingId = $bookingId;
    }

    /**
     * Get the channels the event should broadcast on.
     *
     * @return array<int, \Illuminate\Broadcasting\Channel>
     */
     public function broadcastOn(): Channel
    {
        return new Channel('room-updates');
    }
    public function broadcastAs(): string
    {
        return 'room.quantity.updated';
    }
}
