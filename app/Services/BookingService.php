<?php

namespace App\Services;

class BookingService
{
    public function buildCancellationData(int $totalPrice, int $diffDays, int $cancelFreeDays): array
    {
        if ($diffDays > $cancelFreeDays) {
            return ['cancel_fee' => 0, 'refund_amount' => $totalPrice, 'is_free' => true];
        }

        if ($diffDays > 0 && $diffDays <= $cancelFreeDays) {
            $cancelFee = (int) round($totalPrice * 0.5);
            return ['cancel_fee' => $cancelFee, 'refund_amount' => $totalPrice - $cancelFee, 'is_free' => false];
        }

        return ['cancel_fee' => $totalPrice, 'refund_amount' => 0, 'is_free' => false];
    }
}
