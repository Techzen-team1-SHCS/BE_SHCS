<?php

namespace App\Events;

use App\Models\Booking;
use Illuminate\Broadcasting\Channel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class BookingCancelled implements ShouldBroadcastNow
{
    use Dispatchable, SerializesModels;

    public $booking;

    public function __construct(Booking $booking)
    {
        $this->booking = $booking->load(['room']);
    }

    public function broadcastOn(): Channel
    {
        return new Channel('bookings');
    }

    public function broadcastAs(): string
    {
        return 'booking.cancelled';
    }
}
