<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class PreCheckinEmail extends Mailable
{
    use Queueable, SerializesModels;
    public $booking;
    /**
     * Create a new message instance.
     */
    public function __construct($booking)
    {
        $this->booking = $booking;
    }

    public function build()
    {
        return $this->subject(' Nhắc nhở trước ngày nhận phòng')
                    ->view('mail.pre_checkin')
                    ->with([
                        'customerName' => $this->booking->user->name, // lấy từ quan hệ user
                        'checkInTime'  => $this->booking->check_in->format('H:i d/m/Y'),
                        'hotelName'    => $this->booking->room->hotel->name ?? 'Khách sạn XYZ', // lấy từ quan hệ room->hotel
                        'hotelAddress' => $this->booking->room->hotel->description ?? '123 Nguyễn Huệ, Quận 1, TP.HCM',
                        'contactPhone' => '0774594729'
                    ]);
    }

}
