<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Helpers\NotificationHelper;
use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Hotel;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class HM_BookingController extends Controller
{
    /**
     * GET /hotel-manager/bookings/{id}
     * Lấy danh sách bookings theo hotel — giữ nguyên logic cũ
     */
    public function bookings($id)
    {
        $hotel = Hotel::withoutGlobalScope(\App\Models\Scopes\ApprovedScope::class)->findOrFail($id);
        $this->authorize('viewHotelBookings', $hotel);

        // Sử dụng quan hệ hasManyThrough thay vì where('hotel_id')
        $bookings = $hotel->bookings()
            ->with(['user', 'room'])
            ->latest()
            ->paginate(15); // Thêm phân trang

        return response()->json([
            'status' => true,
            'data'   => $bookings,
        ]);
    }

    /**
     * POST /hotel-manager/bookings/{id}
     * Hotel Manager cập nhật trạng thái booking của khách
     */
    public function update_booking_status($id, Request $request)
    {
        $booking = Booking::with('user')->findOrFail($id);
        $this->authorize('update', $booking);

        $request->validate([
            'status' => ['required', Rule::in(['confirmed', 'cancelled'])],
        ]);

        $booking->update(['status' => $request->status]);

        // ─── 🟢 Notify USER: booking được xác nhận ────────────────────────
        if ($request->status === 'confirmed') {
            NotificationHelper::send(
                $booking->user_id,
                'booking_confirmed',
                '✅ Booking được xác nhận!',
                "Booking #{$booking->id} của bạn đã được khách sạn xác nhận. "
                    . "Check-in: {$booking->check_in}. Hãy chuẩn bị hành lý!",
                ['booking_id' => $booking->id]
            );
        }

        // ─── 🟡 Notify USER: HM hủy booking ──────────────────────────────
        if ($request->status === 'cancelled') {
            NotificationHelper::send(
                $booking->user_id,
                'booking_cancelled',
                '⚠️ Booking bị hủy',
                "Booking #{$booking->id} của bạn đã bị khách sạn hủy. "
                    . "Vui lòng liên hệ hỗ trợ nếu cần thêm thông tin.",
                ['booking_id' => $booking->id]
            );
        }

        return response()->json([
            'status'  => true,
            'message' => 'Cập nhật trạng thái booking thành công',
            'data'    => $booking,
        ]);
    }
}
