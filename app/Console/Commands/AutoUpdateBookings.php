<?php

namespace App\Console\Commands;

use App\Models\Booking;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Laravel\Reverb\Loggers\Log;

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
        $now=Carbon::now();
        //Hủy các booking pending quá hạn chưa thanh toán sau 30p
        $expiredPendingBookings=Booking::where('status','pending')
            ->where('created_at','<=',$now->copy()->subMinutes(30))
            ->get();
        foreach ($expiredPendingBookings as $booking){
            if($booking->room){
                $booking->room->increment('quantity',$booking->quantity);
            }
            $booking->update(['status'=>'cancelled']);
            Log::info("Booking #{$booking->id} đã bị hủy do quá hạn thanh toán.");
        }
        $expiredConfirmedBookings=Booking::where('status','confirmed')
            ->where('check_out','<=',$now)
            ->get();
        foreach ($expiredConfirmedBookings as $booking){
            if($booking->room){
                $booking->room->increment('quantity',$booking->quantity);
            }
            $booking->update(['status'=>'completed']);
            Log::info("Booking #{$booking->id} đã được đánh dấu hoàn thành.");
        }
        $this->info('✅ Đã tự động cập nhật booking và hoàn phòng.');
    }
}
