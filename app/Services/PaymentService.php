<?php

namespace App\Services;

use App\Helpers\NotificationHelper;
use App\Jobs\SendInvoiceJob;
use App\Models\Booking;
use App\Models\Payment;
use Illuminate\Http\Client\PendingRequest;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Http;

class PaymentService
{
    public function qrClient(): PendingRequest
    {
        return Http::timeout(8)->retry(2, 200);
    }

    public function enqueueInvoice(int $bookingId): void
    {
        SendInvoiceJob::dispatch($bookingId);
    }

    public function processCassoTransactions(Collection $transactions): void
    {
        $bookings = Booking::whereIn('status', ['pending', 'confirmed'])
            ->where('payment_status', '!=', 'paid')
            ->whereNotNull('payment_code')
            ->get()
            ->keyBy(fn ($b) => strtoupper($b->payment_code));

        foreach ($transactions as $transaction) {
            $description = strtoupper((string) ($transaction['description'] ?? ''));
            $amount = (int) ($transaction['amount'] ?? 0);
            $tid = (string) ($transaction['tid'] ?? '');
            if (!$tid) {
                continue;
            }

            $matchedBooking = $bookings->first(fn ($booking, $paymentCode) => str_contains($description, $paymentCode));
            if (!$matchedBooking || $amount < (int) $matchedBooking->total_price) {
                continue;
            }

            if (Payment::where('vnp_txn_ref', $tid)->exists()) {
                continue;
            }

            $matchedBooking->update([
                'status' => 'completed',
                'payment_status' => 'paid',
            ]);
            Cache::forget('dashboard_stats');
            Cache::forget('dashboard_summary');

            Payment::create([
                'user_id' => $matchedBooking->user_id,
                'booking_id' => $matchedBooking->id,
                'amount' => $amount,
                'status' => 'paid',
                'payment_method' => 'casso_qr',
                'vnp_txn_ref' => $tid,
            ]);

            NotificationHelper::send(
                $matchedBooking->user_id,
                'payment',
                'Thanh toán thành công qua mã QR',
                "Booking #{$matchedBooking->id} đã thanh toán thành công (Mã CK: {$tid})"
            );

            $this->enqueueInvoice($matchedBooking->id);
        }
    }
}
