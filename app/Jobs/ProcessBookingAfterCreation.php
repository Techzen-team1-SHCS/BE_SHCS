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
        // Đảm bảo load đầy đủ quan hệ để lấy tên user và hotel
        $this->booking->loadMissing(['user', 'room.hotel']);

        $room = $this->booking->room;
        $hotelOwnerId = $room->hotel->user_id ?? null;

        // ─── 2. Gửi thông báo cho HOTEL MANAGER (Đơn hàng mới) 🔵 ─────────
        if ($hotelOwnerId) {
            NotificationHelper::send(
                $hotelOwnerId,
                'new_booking',
                '📬 Bạn có đơn đặt phòng mới',
                "Khách hàng {$this->booking->user->name} vừa đặt phòng #{$this->booking->id}.",
                ['booking_id' => $this->booking->id]
            );
        }

        // ─── 3. Notify HOTEL MANAGER: phòng sắp hết 🟡 ────────────────────
        if ($hotelOwnerId && $this->newQuantity > 0 && $this->newQuantity <= 2) {
            NotificationHelper::send(
                $hotelOwnerId,
                'room_low_stock',
                '⚠️ Phòng sắp hết',
                "Loại phòng " . ($room->room_type ?? 'phòng') . " chỉ còn {$this->newQuantity} phòng trống.",
                [
                    'room_id'            => $this->booking->room_id,
                    'available_quantity' => $this->newQuantity,
                ]
            );
        }

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
