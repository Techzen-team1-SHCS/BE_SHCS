<?php

namespace App\Mail;

use App\Models\Booking;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class PaymentBilling extends Mailable
{
    use Queueable, SerializesModels;

    /**
     * Create a new message instance.
     */
    public $booking;
    public $pdfPath;
    public function __construct(Booking $booking,$pdfPath)
    {
        $this->booking=$booking;
        $this->pdfPath=$pdfPath;
    }
    public function build()
    {
        return $this->subject('Hóa đơn đặt phòng #' . $this->booking->id)
                    ->view('mail.billing')
                    ->attach($this->pdfPath, [
                        'as' => 'invoice-' . $this->booking->id . '.pdf',
                        'mime' => 'application/pdf',
                    ]);
    }

}
