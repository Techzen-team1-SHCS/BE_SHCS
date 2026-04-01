<?php

namespace App\Console\Commands;

use App\Helpers\NotificationHelper;
use App\Models\Booking;
use Carbon\Carbon;
use Illuminate\Console\Command;

class NotifyCheckInOut extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'notify:checkin-checkout';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Gửi thông báo cho Hotel Manager về danh sách khách check-in và check-out hôm nay';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $today = Carbon::today()->toDateString();
        
        // --- 1. Notify Check-In Today 🔴 ---
        $checkInBookings = Booking::with('room.hotel', 'user')
            ->where('status', 'confirmed') // Hoặc cả pending tuỳ logic, thường confirm mới tính
            ->whereDate('check_in', $today)
            ->get();

        foreach ($checkInBookings as $booking) {
            $hotelOwnerId = optional(optional($booking->room)->hotel)->user_id;

            if ($hotelOwnerId) {
                NotificationHelper::send(
                    $hotelOwnerId,
                    'check_in_today',
                    '🔴 Khách Check-in hôm nay',
                    "Booking #{$booking->id}: Khách {$booking->user->name} sẽ check-in hôm nay (" . ($booking->room->room_type ?? 'phòng') .").",
                    [
                        'booking_id' => $booking->id,
                        'user_name'  => $booking->user->name,
                    ]
                );
            }
        }

        $this->info("Đã gửi " . $checkInBookings->count() . " thông báo Check-in.");

        // --- 2. Notify Check-Out Today 🔴 ---
        $checkOutBookings = Booking::with('room.hotel', 'user')
            ->where('status', 'confirmed')
            ->whereDate('check_out', $today)
            ->get();

        foreach ($checkOutBookings as $booking) {
            $hotelOwnerId = optional(optional($booking->room)->hotel)->user_id;

            if ($hotelOwnerId) {
                NotificationHelper::send(
                    $hotelOwnerId,
                    'check_out_today',
                    '🔴 Khách Check-out hôm nay',
                    "Booking #{$booking->id}: Khách {$booking->user->name} sẽ check-out hôm nay (" . ($booking->room->room_type ?? 'phòng') .").",
                    [
                        'booking_id' => $booking->id,
                        'user_name'  => $booking->user->name,
                    ]
                );
            }
        }

        $this->info("Đã gửi " . $checkOutBookings->count() . " thông báo Check-out.");
        
        return 0;
    }
}
