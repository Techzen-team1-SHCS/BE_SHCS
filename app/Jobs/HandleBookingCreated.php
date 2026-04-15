<?php

namespace App\Jobs;

use App\Models\Booking;
use App\Models\RoomNumber;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Redis;

class HandleBookingCreated implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    public $bookingId;
    public $newQuantity;
    public $selectedRooms;
    /**
     * Create a new job instance.
     */
    public function __construct($bookingId, $newQuantity, $selectedRooms)
    {
        $this->bookingId = $bookingId;
        $this->newQuantity = $newQuantity;
        $this->selectedRooms = $selectedRooms;
    }

    /**
     * Execute the job.
     */
    public function handle()
    {
        $booking = Booking::find($this->bookingId);
        if (!$booking) return;

        $userHoldingKey = 'user_pending_bookings:' . $booking->user_id;

        if (!empty($this->selectedRooms)) {
            $roomNumArray = array_map('trim', explode(',', $this->selectedRooms));

            RoomNumber::where('room_id', $booking->room_id)
                ->whereIn('room_number', $roomNumArray)
                ->update(['status' => 'booked','fo_status'=>'occupied']);
        }

        ProcessBookingAfterCreation::dispatch($booking, $this->newQuantity);

        AutoCancelBooking::dispatch($booking->id)
            ->delay(now()->addMinutes(10));

        // 5. Clear cache
        Cache::forget('dashboard_stats');
        Cache::forget('dashboard_summary');
    }
}
