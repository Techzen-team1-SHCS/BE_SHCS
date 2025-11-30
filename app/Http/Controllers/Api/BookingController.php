<?php

namespace App\Http\Controllers\Api;

use App\Events\BookingCreated;
use App\Events\RoomQuantityUpdated;
use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Notification;
use App\Models\Payment;
use App\Models\Room;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;
use Laravel\Reverb\Loggers\Log;
use App\Helpers\NotificationHelper;

class BookingController extends Controller
{
    public function index(){
        $bookings=Booking::with(['user','room'])->orderBy('created_at','desc')->get();
        return response()->json(['data'=>$bookings]);
    }
    public function show($id){
        $booking=Booking::with(['room','room.hotel','room.hotel.images'])->findOrFail($id);
        if(!$booking){
          return response()->json([
            'status'=>404,
            'error'=>'Booking not found'
          ]);
        }
        return response()->json([
            'status'=>200,
            'data'=>$booking,
            'success'=>'Get booking successfully'
        ]);
    }
    public function getBookingUser()
    {
        $user = Auth::user();

        // Lấy danh sách booking theo user_id, kèm quan hệ
        $bookings = Booking::with(['room', 'room.hotel', 'room.hotel.images'])
            ->where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();

        // Nếu không có booking nào
        if ($bookings->isEmpty()) {
            return response()->json([
                'status' => 404,
                'message' => 'Không tìm thấy booking nào'
            ], 404);
        }

        // Trả về danh sách booking
        return response()->json([
            'status' => 200,
            'data' => $bookings
        ], 200);
    }
    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'room_id' => 'required|exists:rooms,id',
            'check_in' => 'required|date|after_or_equal:today',
            'check_out' => 'required|date|after:check_in',
            'quantity' => 'required|integer|min:1'
        ]);

        DB::beginTransaction();

        try {
            // 🔒 LOCK để tránh race condition
            $room = Room::where('id', $request->room_id)
                ->lockForUpdate()
                ->first();

            if (!$room) {
                return response()->json(['message' => 'Room not found'], 404);
            }

            // Kiểm tra số lượng REAL-TIME
            if ($room->quantity < $request->quantity) {
                DB::rollBack();
                return response()->json([
                    'message' => 'Not enough rooms available. Only ' . $room->quantity . ' rooms left.',
                    'available_quantity' => $room->quantity
                ], 400);
            }

            // Tính tổng tiền
            $checkIn = Carbon::parse($request->check_in);
            $checkOut = Carbon::parse($request->check_out);
            $nights = $checkIn->diffInDays($checkOut);
            $totalPrice = $room->price * $nights * $request->quantity;

            // Tạo booking
            $booking = Booking::create([
                'user_id' => $request->user_id,
                'room_id' => $request->room_id,
                'check_in' => $request->check_in,
                'check_out' => $request->check_out,
                'quantity' => $request->quantity,
                'total_price' => $totalPrice,
                'status' => 'pending'
            ]);
             if ($booking) {
                NotificationHelper::send(
                    $booking->user_id,
                    'booking',
                    'Đặt phòng thành công',
                    "Booking #{$booking->id} của bạn đã được đặt thành công với tổng giá "
                    . number_format($booking->total_price, 0, ',', '.') . " VND.",
                    ['booking_id' => $booking->id]
                );
            }
            // Giảm số lượng phòng
            $room->decrement('quantity', $request->quantity);
            $newQuantity = $room->fresh()->quantity; // Lấy giá trị mới nhất

            DB::commit();

            // 📢 Broadcast realtime updates
            event(new RoomQuantityUpdated($room->id, $newQuantity, 'booked', $booking->id));
            event(new BookingCreated($booking));

            return response()->json([
                'success' => true,
                'message' => 'Booking created successfully',
                'data' => $booking->load(['user', 'room']),
                'available_quantity' => $newQuantity
            ], 201);

        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Failed to create booking',
                'error' => $e->getMessage()
            ], 500);
        }
    }
    public function update($id,Request $request){
        $booking=Booking::with(['user','room'])->findOrFail($id);
        $request->validate([
            'check_in' => 'sometimes|date|after_or_equal:today',
            'check_out' => 'sometimes|date|after:check_in',
            'total_amount' => 'sometimes|numeric|min:0',
            'status' => ['sometimes', Rule::in(['pending','confirmed','cancelled','completed'])]
        ]);
        $booking->update($request->all());
        return response()->json([
            'status'=>'success',
            'data'=>$booking,
            'message'=>'Cập nhật Booking thành công'
        ]);
    }
    public function destroy($id){
        $booking=Booking::find($id);
        if(!$booking){
            return response()->json([
                'message'=>'Booking not found'
            ],404);
        }
        $booking->delete();
        return response()->json([
            'message'=>'Booking deleted'
        ]);
    }
    public function cancel($id)
    {
        DB::beginTransaction();

        try {
            $booking = Booking::with('room', 'user')->find($id);

            if (!$booking) {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking not found'
                ], 404);
            }

            if ($booking->status === 'cancelled') {
                return response()->json([
                    'success' => false,
                    'message' => 'Booking is already cancelled'
                ], 400);
            }

            $now = Carbon::now();
            $checkIn = Carbon::parse($booking->check_in);
            $cancelFreeDays = $booking->cancel_free_days ?? 3;

            // Tính số ngày đến check-in
            $diffDays = $now->diffInDays($checkIn, false);

            // Nếu hôm nay là ngày check-in -> diffDays = 0
            if ($now->isSameDay($checkIn)) {
                $diffDays = 0;
            }

            // Tính phí
            if ($diffDays > $cancelFreeDays) {
                $cancelFee = 0;
                $refundAmount = $booking->total_price;
                $isFree = true;
            } elseif ($diffDays > 0 && $diffDays <= $cancelFreeDays) {
                $cancelFee = round($booking->total_price * 0.5);
                $refundAmount = $booking->total_price - $cancelFee;
                $isFree = false;
            } else {
                // Đúng ngày check-in hoặc qua ngày -> Không hoàn tiền
                $cancelFee = $booking->total_price;
                $refundAmount = 0;
                $isFree = false;
            }

            // LOCK room
            $room = Room::where('id', $booking->room_id)->lockForUpdate()->first();
            if (!$room) {
                throw new \Exception("Room not found for booking #{$booking->id}");
            }

            // Cập nhật số lượng phòng
            $newQuantity = max($room->quantity + $booking->quantity, 0);
            $room->update(['quantity' => $newQuantity]);

            // Cập nhật booking
            $booking->update([
                'status' => 'cancelled',
                'cancel_fee' => $cancelFee,
                'cancelled_at' => now(),
                'payment_status' => $refundAmount > 0 ? 'refunded' : 'not_refunded'
            ]);

            // Refund nếu có
            if ($refundAmount > 0 && $booking->user) {
                $booking->user->wallet_balance += $refundAmount;
                $booking->user->save();
            }

            DB::commit();
            return response()->json([
                'success' => true,
                'message' => $isFree
                    ? 'Hủy phòng thành công, không mất phí.'
                    : 'Hủy phòng thành công, phí hủy: ' . number_format($cancelFee, 0, ',', '.') . ' VND.',
                'data' => [
                    'booking' => $booking->load(['user', 'room']),
                    'cancel_fee' => $cancelFee,
                    'refund_amount' => $refundAmount,
                    'is_free' => $isFree,
                    'available_quantity' => $newQuantity,
                ]
            ]);

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Lỗi hủy booking #{$id}: " . $e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Failed to cancel booking',
                'error' => $e->getMessage()
            ], 500);
        }
    }


    public function processCancelledBookings()
    {
        $bookings = Booking::where('status', 'cancelled')
                            ->where('payment_status', 'paid') // chỉ quan tâm booking đã thanh toán
                            ->whereNull('cancel_fee') // chưa tính phí hủy
                            ->get();

        foreach ($bookings as $booking) {
            try {
                DB::beginTransaction();

                $today = Carbon::now();
                $checkIn = Carbon::parse($booking->check_in);
                $diffDays = $today->diffInDays($checkIn, false); // số ngày từ hôm nay tới check-in

                // Quy tắc hoàn tiền

                $diffDays = $today->diffInDays($checkIn); // luôn dương

                if ($diffDays > $booking->cancel_free_days) {
                    // Hủy trước mốc miễn phí → full refund
                    $cancelFee = 0;
                    $refundAmount = $booking->total_price;
                } elseif ($diffDays > 0 && $diffDays <= $booking->cancel_free_days) {
                    // Hủy trong khoảng 3 ngày → 50%
                    $cancelFee = round($booking->total_price * 0.5);
                    $refundAmount = $booking->total_price - $cancelFee;
                } else {
                    // Sát ngày hoặc đã qua → 0%
                    $cancelFee = $booking->total_price;
                    $refundAmount = 0;
                }
                // Cập nhật booking
                $booking->update([
                    'cancel_fee' => $cancelFee,
                    'payment_status' => $refundAmount > 0 ? 'refunded' : 'not_refunded',
                ]);

                // Cập nhật payment liên quan
                $payment = Payment::where('booking_id', $booking->id)
                                ->where('status', 'paid')
                                ->first();
                // --- Thêm ví nội bộ cho user ---
                if ($refundAmount > 0) {
                    $user = $booking->user;
                    if ($user) {
                        $user->wallet_balance += $refundAmount;
                        $user->save();
                        Log::info("Booking #{$booking->id}: Refund $refundAmount VND added to user #{$user->id} wallet");
                    }
                }

                DB::commit();

            } catch (\Exception $e) {
                DB::rollBack();
                Log::error("Lỗi xử lý hoàn tiền booking #{$booking->id}: " . $e->getMessage());
            }
        }

        return response()->json([
            'status' => 'success',
            'message' => 'Đã xử lý các booking hủy theo quy định'
        ]);
    }



      public function getRealtimeQuantity($id)
    {
        $room = Room::find($id);
        if (!$room) {
            return response()->json(['message' => 'Room not found'], 404);
        }

        return response()->json([
            'success' => true,
            'room_id' => $room->id,
            'available_quantity' => $room->quantity,
            'room_type' => $room->room_type,
            'price' => $room->price,
            'last_updated' => now()->toISOString()
        ]);
    }

}
