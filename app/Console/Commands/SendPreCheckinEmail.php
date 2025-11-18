<?php

namespace App\Console\Commands;

use App\Mail\PreCheckinEmail;
use App\Models\Booking;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;

class SendPreCheckinEmail extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:send-pre-checkin-email';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Send pre check-in reminder emails to customers';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $tomorrow = now()->addDay()->toDateString(); // ngày mai

        $bookings = Booking::where('status', 'confirmed')
        ->whereDate('check_in', $tomorrow)
        ->where('pre_checkin_email_sent', false) // chỉ những booking chưa gửi email
        ->with('user','room.hotel')
        ->get();

    foreach ($bookings as $booking) {
        Mail::to($booking->user->email)->send(new PreCheckinEmail($booking));

        // đánh dấu đã gửi
        $booking->pre_checkin_email_sent = true;
        $booking->save();
        }
    }
}
