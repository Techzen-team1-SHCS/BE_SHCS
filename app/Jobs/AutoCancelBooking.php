<?php

namespace App\Jobs;

use App\Models\Booking;
use App\Models\Room;
use App\Models\RoomNumber;
use App\Helpers\NotificationHelper;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Events\RoomQuantityUpdated;

class AutoCancelBooking implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $bookingId;

    public function __construct($bookingId)
    {
        $this->bookingId = $bookingId;
    }

    public function handle()
    {
        $booking = Booking::find($this->bookingId);

        // Chỉ hủy nếu trạng thái vẫn là pending và chưa thanh toán
        if (!$booking || $booking->status !== 'pending' || $booking->payment_status === 'paid') {
            return;
        }

        DB::beginTransaction();
        try {
            $room = Room::where('id', $booking->room_id)->lockForUpdate()->first();
            
            if ($room) {
                $room->increment('quantity', $booking->quantity);
                $newQuantity = $room->fresh()->quantity;
            } else {
                $newQuantity = 0;
            }

            // Hoàn lại trạng thái các số phòng
            if (!empty($booking->selected_room_numbers)) {
                $roomNumArray = array_map('trim', explode(',', $booking->selected_room_numbers));
                RoomNumber::where('room_id', $booking->room_id)
                    ->whereIn('room_number', $roomNumArray)
                    ->update(['status' => 'available']);
            }

            $booking->update([
                'status' => 'cancelled',
                'cancelled_at' => now(),
                'payment_status' => 'not_refunded',
            ]);

            // Thông báo cho người dùng
            NotificationHelper::send(
                $booking->user_id,
                'cancel_booking',
                'Booking đã bị tự động hủy',
                "Booking #{$booking->id} đã bị hủy do quá thời gian thanh toán (10 phút).",
                ['booking_id' => $booking->id]
            );

            // Broadcast realtime để cập nhật số lượng phòng trên web
            event(new RoomQuantityUpdated(
                $booking->room_id,
                $newQuantity,
                'cancelled',
                $booking->id
            ));

            DB::commit();
            Log::info("Booking #{$this->bookingId} was auto-cancelled by Job after timeout.");
            
            // Clear cache
            \Illuminate\Support\Facades\Cache::forget('dashboard_stats');
            \Illuminate\Support\Facades\Cache::forget('dashboard_summary');

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Failed to auto-cancel booking #{$this->bookingId}: " . $e->getMessage());
        }
    }
}
