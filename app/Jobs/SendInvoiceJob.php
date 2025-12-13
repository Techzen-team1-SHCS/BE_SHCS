<?php

namespace App\Jobs;

use App\Models\Booking;
use App\Mail\PaymentBilling;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;

class SendInvoiceJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public $bookingId;

    // ⏱ timeout & retry
    public $timeout = 120;
    public $tries = 3;

    public function __construct($bookingId)
    {
        $this->bookingId = $bookingId;
    }

    public function handle()
    {
        try {
            $booking = Booking::with('user', 'room.hotel')->find($this->bookingId);

            if (!$booking) {
                Log::error("Booking not found: {$this->bookingId}");
                return;
            }

            // 1️⃣ Generate PDF
            $pdf = Pdf::loadView('pdf.invoice', compact('booking'));
            $pdfPath = storage_path("app/public/invoice-{$booking->id}.pdf");
            $pdf->save($pdfPath);

            // 2️⃣ Send Mail
            Mail::to($booking->user->email)
                ->send(new PaymentBilling($booking, $pdfPath));

        } catch (\Throwable $e) {
            Log::error('SendInvoiceJob failed: ' . $e->getMessage());
            throw $e; // để queue retry
        }
    }
}
