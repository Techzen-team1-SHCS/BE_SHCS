<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class HotelRejected implements ShouldBroadcast
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $hotel;
    public $reason;

    public function __construct($hotel, $reason)
    {
        $this->hotel = $hotel;
        $this->reason = $reason;
    }

    public function broadcastOn()
    {
        return new Channel('admin-notification');
    }

    public function broadcastAs()
    {
        return 'hotel.rejected';
    }
}