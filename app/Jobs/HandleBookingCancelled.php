<?php

namespace App\Jobs;

use App\Events\BookingCancelled;
use App\Models\Booking;
use App\Models\RoomNumber;
use App\Helpers\NotificationHelper;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Cache;

class HandleBookingCancelled implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $bookingId;
    public $newQuantity;

    /**
     * Create a new job instance.
     */
    public function __construct($bookingId, $newQuantity)
    {
        $this->bookingId = $bookingId;
        $this->newQuantity = $newQuantity;
    }

    /**
     * Execute the job.
     */
    public function handle()
    {
        $booking = Booking::with('room.hotel', 'user')->find($this->bookingId);
        if (!$booking) return;

        // 1. Khôi phục trạng thái các RoomNumber cụ thể thành 'available'
        if ($booking->selected_room_numbers) {
            $roomNumArray = array_map('trim', explode(',', $booking->selected_room_numbers));

            RoomNumber::where('room_id', $booking->room_id)
                ->whereIn('room_number', $roomNumArray)
                ->update(['status' => 'available']);
        }

        // 1.1. Xóa hold Redis ngay để tab khác thấy phòng trống lập tức
        if ($booking->selected_room_numbers) {
            $roomNumArray = array_map('trim', explode(',', $booking->selected_room_numbers));
            foreach ($roomNumArray as $roomNumber) {
                Cache::forget('room_hold:' . $booking->room_id . ':' . $roomNumber);
            }
        }

        // 2. Gửi thông báo cho HOTEL MANAGER
        $hotelOwnerId = optional(optional($booking->room)->hotel)->user_id;
        if ($hotelOwnerId && $hotelOwnerId !== $booking->user_id) {
            NotificationHelper::send(
                $hotelOwnerId,
                'booking_cancelled',
                '⚠️ Khách hủy booking',
                "Booking #{$booking->id} đã bị hủy bởi khách. Phòng trống hiện tại: {$this->newQuantity}.",
                ['booking_id' => $booking->id, 'available_quantity' => $this->newQuantity]
            );
        }

        // 4. Xóa cache dashboard
        Cache::forget('dashboard_stats');
        Cache::forget('dashboard_summary');

        event(new BookingCancelled($booking));
    }
}
