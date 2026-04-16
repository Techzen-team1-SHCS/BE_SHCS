<?php

namespace App\Services;
use App\Jobs\HandleBookingCreated;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\RateLimiter;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;
use App\Models\Room;
use App\Models\Booking;
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

        // 1. Rate Limit
        $apiRateLimitKey = 'rate_limit_booking:' . $userId;
        if (RateLimiter::tooManyAttempts($apiRateLimitKey, 5)) {
            return [
                'success' => false,
                'status' => 429,
                'message' => 'Bạn đang thao tác quá nhanh. Vui lòng thử lại sau 1 phút.'
            ];
        }
        RateLimiter::hit($apiRateLimitKey, 60);

        // 2. Anti-Hoarding
        $userHoldingKey = 'user_pending_bookings:' . $userId;

        $count = Redis::get($userHoldingKey);

        if ($count === null) {
            $count = Booking::where('user_id', $userId)
                ->where('status', 'pending')
                ->where('created_at', '>=', now()->subMinutes(15))
                ->count();

            Redis::setex($userHoldingKey, 900, $count);
        }

        if ((int)$count >= 3) {
            return [
                'success' => false,
                'status' => 429,
                'message' => 'Bạn đang có quá nhiều đơn hàng chưa thanh toán.'
            ];
        }

        $selectedRoomNumbers = $this->normalizeRoomNumbers($data['selected_room_numbers'] ?? null);
        $holdDuration = 5 * 60;
        $bookingHoldKeys = [];

        foreach ($selectedRoomNumbers as $roomNumber) {
            $bookingHoldKeys[] = 'room_hold:' . $data['room_id'] . ':' . $roomNumber;
        }

        DB::beginTransaction();

        try {
            $room = Room::where('id', $data['room_id'])
                ->lockForUpdate()
                ->first();

            if (!$room) {
                DB::rollBack();
                return [
                    'success' => false,
                    'status' => 404,
                    'message' => 'Không tìm thấy phòng.'
                ];
            }

            if (!empty($selectedRoomNumbers)) {
                foreach ($bookingHoldKeys as $holdKey) {
                    if (!Cache::add($holdKey, $userId, $holdDuration)) {
                        DB::rollBack();
                        return [
                            'success' => false,
                            'status' => 409,
                            'message' => 'Một hoặc nhiều số phòng bạn chọn đang được giữ tạm thời bởi người khác. Vui lòng chọn phòng khác hoặc thử lại sau vài phút.'
                        ];
                    }
                }

                $conflictingRoomNumbers = Booking::query()
                    ->where('room_id', $room->id)
                    ->whereIn('status', ['pending', 'confirmed'])
                    ->where(function ($query) use ($data) {
                        $query->where(function ($query) use ($data) {
                            $query->whereDate('check_in', '<', $data['check_out'])
                                  ->whereDate('check_out', '>', $data['check_in']);
                        });
                    })
                    ->whereRaw("JSON_VALID(COALESCE(selected_room_numbers, '[]'))")
                    ->get(['selected_room_numbers'])
                    ->filter(function ($booking) use ($selectedRoomNumbers) {
                        $bookedNumbers = $this->normalizeRoomNumbers($booking->selected_room_numbers);
                        return !empty(array_intersect($bookedNumbers, $selectedRoomNumbers));
                    })
                    ->isNotEmpty();

                if ($conflictingRoomNumbers) {
                    foreach ($bookingHoldKeys as $holdKey) {
                        Cache::forget($holdKey);
                    }
                    DB::rollBack();
                    return [
                        'success' => false,
                        'status' => 409,
                        'message' => 'Một hoặc nhiều số phòng bạn chọn đã được đặt cho khoảng thời gian này.'
                    ];
                }
            }

            if ($room->quantity < $data['quantity']) {
                DB::rollBack();
                return [
                    'success' => false,
                    'status' => 400,
                    'message' => 'Không đủ số lượng phòng trống.',
                    'available_quantity' => $room->quantity
                ];
            }

            // Tính toán giá
            $nights = Carbon::parse($data['check_in'])
                ->diffInDays(Carbon::parse($data['check_out']));

            $totalPrice = $room->price * $nights * $data['quantity'];

            // Create booking
            $booking = Booking::create([
                'user_id'   => $userId,
                'room_id'   => $data['room_id'],
                'check_in'  => $data['check_in'],
                'check_out' => $data['check_out'],
                'quantity'  => $data['quantity'],
                'selected_room_numbers' => $selectedRoomNumbers ? json_encode($selectedRoomNumbers, JSON_UNESCAPED_UNICODE) : null,
                'total_price' => $totalPrice,
                'status'    => 'pending',
            ]);

            $booking->payment_code =
                strtoupper(substr(now()->format('l'), 0, 2)) .
                now()->format('dm') .
                $booking->id;

            $booking->save();

            // Giữ phòng (QUAN TRỌNG → phải sync)
            $room->decrement('quantity', $data['quantity']);
            $newQuantity = $room->fresh()->quantity;

            DB::commit();
            Redis::incr($userHoldingKey);
            Redis::expire($userHoldingKey, 900);
            // 🚀 Gửi thông báo REALTIME ngay lập tức cho khách hàng
            \App\Helpers\NotificationHelper::send(
                $userId,
                'booking',
                'Đặt phòng thành công',
                "Booking #{$booking->id} của bạn đã được đặt thành công. Vui lòng kiểm tra lại đơn hàng.",
                ['booking_id' => $booking->id]
            );

            // 🔥 Dispatch 1 job duy nhất xử lý các tác vụ background (Manager notifications, RoomNumber, etc.)
            HandleBookingCreated::dispatch(
                $booking->id,
                $newQuantity,
                $data['selected_room_numbers']
            )->onQueue('booking');

            return [
                'success' => true,
                'status'  => 201,
                'message' => 'Đặt phòng thành công.',
                'data'    => $booking,
                'available_quantity' => $newQuantity
            ];

        } catch (\Exception $e) {
            DB::rollBack();

            foreach ($bookingHoldKeys as $holdKey) {
                Cache::forget($holdKey);
            }

            return [
                'success' => false,
                'status' => 500,
                'message' => 'Lỗi hệ thống khi đặt phòng.',
                'error' => $e->getMessage()
            ];
        }
    }

    public function holdRoomNumber(int $roomId, string $roomNumber, int $userId, int $holdDuration = 300): array
    {
        $key = 'room_hold:' . $roomId . ':' . $roomNumber;
        $currentHolder = Cache::get($key);

        if ($currentHolder !== null && (string) $currentHolder !== (string) $userId) {
            return [
                'success' => false,
                'status' => 409,
                'message' => 'Phòng này đang được giữ tạm thời bởi người khác.'
            ];
        }

        Cache::put($key, (string) $userId, $holdDuration);

        return [
            'success' => true,
            'status' => 200,
            'message' => 'Đã giữ chỗ thành công.',
            'hold_key' => $key
        ];
    }

    public function releaseRoomNumber(int $roomId, string $roomNumber, int $userId): array
    {
        $key = 'room_hold:' . $roomId . ':' . $roomNumber;
        $currentHolder = Cache::get($key);

        if ((string) $currentHolder !== (string) $userId) {
            return [
                'success' => false,
                'status' => 403,
                'message' => 'Bạn không có quyền giải phóng phòng này.'
            ];
        }

        Cache::forget($key);

        return [
            'success' => true,
            'status' => 200,
            'message' => 'Đã bỏ giữ chỗ.'
        ];
    }

    public function getHeldRoomNumbers(int $roomId): array
    {
        $heldRoomNumbers = [];

        try {
            $keys = Redis::connection()->keys('room_hold:' . $roomId . ':*');

            foreach ($keys as $key) {
                $parts = explode(':', $key);
                $heldRoomNumbers[] = end($parts);
            }
        } catch (\Exception) {
            return [];
        }

        return array_values(array_unique(array_filter(array_map('trim', $heldRoomNumbers), static fn ($value) => $value !== '')));
    }

    private function normalizeRoomNumbers($roomNumbers): array
    {
        if (is_array($roomNumbers)) {
            return array_values(array_filter(array_map('trim', $roomNumbers), static fn ($value) => $value !== ''));
        }

        if (is_string($roomNumbers) && $roomNumbers !== '') {
            $decoded = json_decode($roomNumbers, true);

            if (json_last_error() === JSON_ERROR_NONE && is_array($decoded)) {
                return array_values(array_filter(array_map('trim', $decoded), static fn ($value) => $value !== ''));
            }

            return array_values(array_filter(array_map('trim', preg_split('/[,\s]+/', $roomNumbers) ?: []), static fn ($value) => $value !== ''));
        }

        return [];
    }

    public function cancelBooking(int $id)
    {
        DB::beginTransaction();

        try {
            $booking = Booking::with('user')->find($id);

            if (!$booking) {
                return ['success' => false, 'status' => 404, 'message' => 'Không tìm thấy đơn đặt phòng.'];
            }

            if ($booking->status === 'cancelled') {
                return ['success' => false, 'status' => 400, 'message' => 'Đơn đặt phòng này đã được hủy trước đó.'];
            }

            $now             = Carbon::now();
            $checkIn         = Carbon::parse($booking->check_in);
            $cancelFreeDays  = $booking->cancel_free_days ?? 3;
            $diffDays        = $now->diffInDays($checkIn, false);

            if ($now->isSameDay($checkIn)) {
                $diffDays = 0;
            }

            $cancelData = $this->buildCancellationData(
                (int) $booking->total_price,
                (int) $diffDays,
                (int) $cancelFreeDays
            );
            
            $cancelFee = $cancelData['cancel_fee'];
            $refundAmount = $cancelData['refund_amount'];
            $isFree = $cancelData['is_free'];

            // 1. Lock room và cập nhật số lượng (QUAN TRỌNG → Sync)
            $room = Room::where('id', $booking->room_id)->lockForUpdate()->first();
            if (!$room) {
                throw new \Exception("Không tìm thấy thông tin phòng cho đơn hàng #{$booking->id}");
            }

            $newQuantity = $room->quantity + $booking->quantity;
            $room->update(['quantity' => $newQuantity]);

            // 2. Cập nhật trạng thái Booking (Sync)
            $booking->update([
                'status'         => 'cancelled',
                'cancel_fee'     => $cancelFee,
                'cancelled_at'   => now(),
                'payment_status' => $refundAmount > 0 ? 'refunded' : 'not_refunded'
            ]);

            // 3. Nhả hold phòng ngay lập tức để người khác đặt lại
            $selectedRoomNumbers = $this->normalizeRoomNumbers($booking->selected_room_numbers ?? null);
            foreach ($selectedRoomNumbers as $roomNumber) {
                Cache::forget('room_hold:' . $booking->room_id . ':' . $roomNumber);
            }

            // 4. Hoàn tiền vào ví (Sync)
            if ($refundAmount > 0 && $booking->user) {
                $booking->user->increment('wallet_balance', $refundAmount);
            }

            DB::commit();
            $userHoldingKey = 'user_pending_bookings:' . $booking->user_id;

            // 🚀 Xóa key để ép hệ thống đếm lại từ DB ở lần đặt phòng tiếp theo (An toàn hơn trừ 1)
            Redis::del($userHoldingKey);
            // 🚀 Gửi thông báo REALTIME ngay lập tức cho khách hàng
            \App\Helpers\NotificationHelper::send(
                $booking->user_id,
                'cancel_booking',
                'Hủy phòng thành công',
                "Booking #{$booking->id} của bạn đã được hủy. Tiền đã được hoàn lại vào ví.",
                ['booking_id' => $booking->id]
            );

            // 4. 🔥 Dispatch Job xử lý các tác vụ nặng (Async)
            \App\Jobs\HandleBookingCancelled::dispatch($booking->id, $newQuantity)->onQueue('booking');

            return [
                'success' => true,
                'status'  => 200,
                'message' => $isFree
                    ? 'Hủy phòng thành công, không mất phí.'
                    : 'Hủy phòng thành công, phí hủy: ' . number_format($cancelFee, 0, ',', '.') . ' VND.',
                'data' => [
                    'booking_id'         => $booking->id,
                    'cancel_fee'         => $cancelFee,
                    'refund_amount'      => $refundAmount,
                    'is_free'            => $isFree,
                    'available_quantity' => $newQuantity,
                ]
            ];
        } catch (\Exception $e) {
            DB::rollBack();
            return [
                'success' => false,
                'status'  => 500,
                'message' => 'Lỗi hệ thống khi hủy đặt phòng.',
                'error'   => $e->getMessage()
            ];
        }
    }
}
