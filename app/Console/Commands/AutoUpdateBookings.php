<?php

namespace App\Console\Commands;

use App\Models\Booking;
use App\Models\Room;
use App\Models\RoomNumber;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class AutoUpdateBookings extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:auto-update-bookings';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Tự động cập nhật trạng thái booking hàng ngày';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $now = Carbon::now();

        // Hủy các booking pending quá hạn sau 15 phút và hoàn phòng/room numbers
        $expiredPendingBookings = Booking::where('status', 'pending')
            ->where('payment_status', '!=', 'paid')
            ->where('created_at', '<=', $now->copy()->subMinutes(15))
            ->get();

        foreach ($expiredPendingBookings as $booking) {
            DB::beginTransaction();
            try {
                $room = Room::where('id', $booking->room_id)->lockForUpdate()->first();
                if ($room) {
                    $room->increment('quantity', $booking->quantity);
                }

                if (!empty($booking->selected_room_numbers)) {
                    $roomNumArray = array_map('trim', explode(',', $booking->selected_room_numbers));
                    RoomNumber::where('room_id', $booking->room_id)
                        ->whereIn('room_number', $roomNumArray)
                        ->update(['status' => 'available']);
                }

                $booking->update([
                    'status' => 'cancelled',
                    'cancelled_at' => $now,
                    'payment_status' => 'not_refunded',
                ]);

                DB::commit();
                Log::info("Booking #{$booking->id} auto-cancelled after 15 minutes.");
            } catch (\Throwable $e) {
                DB::rollBack();
                Log::error("Failed auto-cancel booking #{$booking->id}: " . $e->getMessage());
            }
        }

        $expiredConfirmedBookings = Booking::where('status', 'confirmed')
            ->where('check_out', '<=', $now)
            ->get();

        foreach ($expiredConfirmedBookings as $booking) {
            if ($booking->room) {
                $booking->room->increment('quantity', $booking->quantity);
            }
            $booking->update(['status' => 'completed']);
            Log::info("Booking #{$booking->id} đã được đánh dấu hoàn thành.");
        }
        $this->info('✅ Đã tự động cập nhật booking và hoàn phòng.');
    }
}
