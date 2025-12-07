<?php

namespace App\Jobs;

use App\Helpers\NotificationHelper;
use App\Events\RoomQuantityUpdated;
use App\Events\BookingCreated;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class ProcessBookingAfterCreation implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $booking;
    public $newQuantity;

    public function __construct($booking, $newQuantity)
    {
        $this->booking = $booking;
        $this->newQuantity = $newQuantity;
    }

    public function handle()
    {
        // Gửi thông báo
        NotificationHelper::send(
            $this->booking->user_id,
            'booking',
            'Đặt phòng thành công',
            "Booking #{$this->booking->id} của bạn đã được đặt thành công với tổng giá "
            . number_format($this->booking->total_price, 0, ',', '.') . " VND.",
            ['booking_id' => $this->booking->id]
        );

        // Broadcast realtime
        event(new RoomQuantityUpdated(
            $this->booking->room_id,
            $this->newQuantity,
            'booked',
            $this->booking->id
        ));

        event(new BookingCreated($this->booking));
    }
}
