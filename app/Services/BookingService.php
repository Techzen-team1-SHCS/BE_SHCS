<?php

namespace App\Services;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Cache;
use Carbon\Carbon;
use App\Models\Room;
use App\Models\Booking;
use App\Models\RoomNumber;
use App\Jobs\ProcessBookingAfterCreation;
use App\Jobs\AutoCancelBooking;

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
    
    public function createBooking(array $data)
    {
        $userId = $data['user_id'];

        // 1. Kiểm tra Spam (Rate Limit)
        $apiRateLimitKey = 'rate_limit_booking:' . $userId;
        if (RateLimiter::tooManyAttempts($apiRateLimitKey, 5)) {
            return ['success' => false, 'status' => 429, 'message' => 'Bạn đang thao tác quá nhanh. Vui lòng thử lại sau 1 phút.'];
        }
        RateLimiter::hit($apiRateLimitKey, 60);

        // 2. Kiểm tra Đầu cơ (Anti-Hoarding)
        $userHoldingKey = 'user_pending_bookings:' . $userId;
        if ((Redis::get($userHoldingKey) ?: 0) >= 3) {
            return ['success' => false, 'status' => 429, 'message' => 'Bạn đang có quá nhiều đơn hàng chưa thanh toán.'];
        }

        // 3. Xử lý Database Transaction
        DB::beginTransaction();
        try {
            $room = Room::where('id', $data['room_id'])->lockForUpdate()->first();

            if (!$room) {
                return ['success' => false, 'status' => 404, 'message' => 'Không tìm thấy phòng.'];
            }

            if ($room->quantity < $data['quantity']) {
                DB::rollBack();
                return ['success' => false, 'status' => 400, 'message' => 'Không đủ số lượng phòng trống.', 'available_quantity' => $room->quantity];
            }

            // Tính toán giá tiền
            $nights = Carbon::parse($data['check_in'])->diffInDays(Carbon::parse($data['check_out']));
            $totalPrice = $room->price * $nights * $data['quantity'];
            
            // Tạo Booking
            $booking = Booking::create([
                'user_id'   => $userId,
                'room_id'   => $data['room_id'],
                'check_in'  => $data['check_in'],
                'check_out' => $data['check_out'],
                'quantity'  => $data['quantity'],
                'selected_room_numbers' => $data['selected_room_numbers'],
                'total_price' => $totalPrice,
                'status'    => 'pending',
            ]);

            $booking->payment_code = strtoupper(substr(now()->format('l'), 0, 2)) . now()->format('dm') . $booking->id;
            $booking->save();
            
            // Cập nhật số lượng phòng
            $room->decrement('quantity', $data['quantity']);
            $newQuantity = $room->fresh()->quantity;
            
            // Cập nhật trạng thái số phòng cụ thể (nếu có)
            if (!empty($data['selected_room_numbers'])) {
                $roomNumArray = array_map('trim', explode(',', $data['selected_room_numbers']));
                RoomNumber::where('room_id', $data['room_id'])
                    ->whereIn('room_number', $roomNumArray)
                    ->update(['status' => 'booked']);
            }

            DB::commit();

            // 4. Các tác vụ Post-Creation (Sau khi tạo thành công)
            Redis::incr($userHoldingKey);
            Redis::expire($userHoldingKey, 900); // 15 phút

            ProcessBookingAfterCreation::dispatch($booking, $newQuantity);
            AutoCancelBooking::dispatch($booking->id)->delay(now()->addMinutes(10));
            Cache::forget('dashboard_stats');
            Cache::forget('dashboard_summary');

            return [
                'success' => true,
                'status'  => 201,
                'message' => 'Đặt phòng thành công.',
                'data'    => $booking,
                'available_quantity' => $newQuantity
            ];
            
        } catch (\Exception $e) {
            DB::rollBack();
            return ['success' => false, 'status' => 500, 'message' => 'Lỗi hệ thống khi đặt phòng.', 'error' => $e->getMessage()];
        }
    }
}
