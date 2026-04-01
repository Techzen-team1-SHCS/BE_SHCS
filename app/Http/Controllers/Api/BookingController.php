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
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\Rule;
use App\Helpers\NotificationHelper;
use App\Jobs\ProcessBookingAfterCreation;

class BookingController extends Controller
{
    public function index()
    {
        try {
            $bookings = Booking::query()
                ->select('id', 'user_id', 'room_id', 'check_in', 'check_out', 'total_price', 'status', 'payment_status', 'created_at', 'updated_at', 'quantity')
                ->with([
                    'room:id,quantity,max_guest',
                    'user'
                ])
                ->latest()
                ->get();

            return response()->json($bookings);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to fetch bookings'
            ], 500);
        }
    }

    public function show($id)
    {
        $booking = Booking::with(['room', 'room.hotel', 'room.hotel.images'])->findOrFail($id);
        $this->authorize('view', $booking);
        if (!$booking) {
            return response()->json([
                'status' => 404,
                'error'  => 'Booking not found'
            ]);
        }
        return response()->json([
            'status'  => 200,
            'data'    => $booking,
            'success' => 'Get booking successfully'
        ]);
    }

    public function getBookingUser()
    {
        $user = Auth::user();

        $bookings = Booking::with(['room', 'room.hotel', 'room.hotel.images'])
            ->where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->get();

        if ($bookings->isEmpty()) {
            return response()->json([
                'status'  => 404,
                'message' => 'Không tìm thấy booking nào'
            ], 404);
        }

        return response()->json([
            'status' => 200,
            'data'   => $bookings
        ], 200);
    }

    public function store(Request $request)
    {
        $request->validate([
            'user_id'  => 'required|exists:users,id',
            'room_id'  => 'required|exists:rooms,id',
            'check_in' => 'required|date|after_or_equal:today',
            'check_out'=> 'required|date|after:check_in',
            'quantity' => 'required|integer|min:1'
        ]);

        DB::beginTransaction();
        try {
            $room = Room::where('id', $request->room_id)
                ->lockForUpdate()
                ->first();

            if (!$room) {
                return response()->json(['message' => 'Room not found'], 404);
            }

            if ($room->quantity < $request->quantity) {
                DB::rollBack();
                return response()->json([
                    'message'            => 'Not enough rooms available',
                    'available_quantity' => $room->quantity
                ], 400);
            }

            $nights = Carbon::parse($request->check_in)
                ->diffInDays(Carbon::parse($request->check_out));

            $totalPrice = $room->price * $nights * $request->quantity;

            $booking = Booking::create([
                'user_id'   => $request->user_id,
                'room_id'   => $request->room_id,
                'check_in'  => $request->check_in,
                'check_out' => $request->check_out,
                'quantity'  => $request->quantity,
                'total_price' => $totalPrice,
                'status'    => 'pending'
            ]);

            $room->decrement('quantity', $request->quantity);
            $newQuantity = $room->fresh()->quantity;

            DB::commit();

            // Dispatch job async (notify user + HM + broadcast)
            ProcessBookingAfterCreation::dispatch($booking, $newQuantity);

            return response()->json([
                'success'            => true,
                'message'            => 'Booking created successfully',
                'data'               => $booking,
                'available_quantity' => $newQuantity
            ], 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'success' => false,
                'message' => 'Failed to create booking',
                'error'   => $e->getMessage()
            ], 500);
        }
    }

    public function update($id, Request $request)
    {
        $booking = Booking::with(['user', 'room'])->findOrFail($id);
        $this->authorize('update', $booking);
        $request->validate([
            'check_in'     => 'sometimes|date|after_or_equal:today',
            'check_out'    => 'sometimes|date|after:check_in',
            'total_amount' => 'sometimes|numeric|min:0',
            'status'       => ['sometimes', Rule::in(['pending', 'confirmed', 'cancelled', 'completed'])]
        ]);
        $booking->update($request->all());
        return response()->json([
            'status'  => 'success',
            'data'    => $booking,
            'message' => 'Cập nhật Booking thành công'
        ]);
    }

    public function destroy($id)
    {
        $booking = Booking::find($id);
        $this->authorize('delete', $booking);
        if (!$booking) {
            return response()->json(['message' => 'Booking not found'], 404);
        }
        $booking->delete();
        return response()->json(['message' => 'Booking deleted']);
    }

    public function cancel($id)
    {
        DB::beginTransaction();

        try {
            $booking = Booking::with('room.hotel', 'user')->find($id);
            $this->authorize('delete', $booking);

            if (!$booking) {
                return response()->json(['success' => false, 'message' => 'Booking not found'], 404);
            }

            if ($booking->status === 'cancelled') {
                return response()->json(['success' => false, 'message' => 'Booking is already cancelled'], 400);
            }

            $now             = Carbon::now();
            $checkIn         = Carbon::parse($booking->check_in);
            $cancelFreeDays  = $booking->cancel_free_days ?? 3;
            $diffDays        = $now->diffInDays($checkIn, false);

            if ($now->isSameDay($checkIn)) {
                $diffDays = 0;
            }

            if ($diffDays > $cancelFreeDays) {
                $cancelFee    = 0;
                $refundAmount = $booking->total_price;
                $isFree       = true;
            } elseif ($diffDays > 0 && $diffDays <= $cancelFreeDays) {
                $cancelFee    = round($booking->total_price * 0.5);
                $refundAmount = $booking->total_price - $cancelFee;
                $isFree       = false;
            } else {
                $cancelFee    = $booking->total_price;
                $refundAmount = 0;
                $isFree       = false;
            }

            $room = Room::where('id', $booking->room_id)->lockForUpdate()->first();
            if (!$room) {
                throw new \Exception("Room not found for booking #{$booking->id}");
            }

            $newQuantity = max($room->quantity + $booking->quantity, 0);
            $room->update(['quantity' => $newQuantity]);

            $booking->update([
                'status'         => 'cancelled',
                'cancel_fee'     => $cancelFee,
                'cancelled_at'   => now(),
                'payment_status' => $refundAmount > 0 ? 'refunded' : 'not_refunded'
            ]);

            if ($refundAmount > 0 && $booking->user) {
                $booking->user->wallet_balance += $refundAmount;
                $booking->user->save();
            }

            // 🟡 Notify USER: hủy booking thành công
            NotificationHelper::send(
                $booking->user_id,
                'cancel_booking',
                'Hủy phòng thành công',
                "Booking #{$booking->id} đã được hủy. Phí hủy: "
                    . number_format($cancelFee, 0, ',', '.') . ' VND. Hoàn lại: '
                    . number_format($refundAmount, 0, ',', '.') . ' VND.',
                ['booking_id' => $booking->id]
            );

            // 🟡 Notify HOTEL MANAGER: khách hủy booking
            $hotelOwnerId = optional(optional($booking->room)->hotel)->user_id;
            if ($hotelOwnerId && $hotelOwnerId !== $booking->user_id) {
                NotificationHelper::send(
                    $hotelOwnerId,
                    'booking_cancelled',
                    '⚠️ Khách hủy booking',
                    "Booking #{$booking->id} đã bị hủy bởi khách. Phòng trống trở lại: {$newQuantity}.",
                    ['booking_id' => $booking->id, 'available_quantity' => $newQuantity]
                );
            }

            DB::commit();

            return response()->json([
                'success' => true,
                'message' => $isFree
                    ? 'Hủy phòng thành công, không mất phí.'
                    : 'Hủy phòng thành công, phí hủy: ' . number_format($cancelFee, 0, ',', '.') . ' VND.',
                'data' => [
                    'booking'            => $booking->load(['user', 'room']),
                    'cancel_fee'         => $cancelFee,
                    'refund_amount'      => $refundAmount,
                    'is_free'            => $isFree,
                    'available_quantity' => $newQuantity,
                ]
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Lỗi hủy booking #{$id}: " . $e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Failed to cancel booking',
                'error'   => $e->getMessage()
            ], 500);
        }
    }

    public function processCancelledBookings()
    {
        $bookings = Booking::where('status', 'cancelled')
            ->where('payment_status', 'paid')
            ->whereNull('cancel_fee')
            ->get();

        foreach ($bookings as $booking) {
            try {
                DB::beginTransaction();

                $today    = Carbon::now();
                $checkIn  = Carbon::parse($booking->check_in);
                $diffDays = $today->diffInDays($checkIn);

                if ($diffDays > $booking->cancel_free_days) {
                    $cancelFee    = 0;
                    $refundAmount = $booking->total_price;
                } elseif ($diffDays > 0 && $diffDays <= $booking->cancel_free_days) {
                    $cancelFee    = round($booking->total_price * 0.5);
                    $refundAmount = $booking->total_price - $cancelFee;
                } else {
                    $cancelFee    = $booking->total_price;
                    $refundAmount = 0;
                }

                $booking->update([
                    'cancel_fee'     => $cancelFee,
                    'payment_status' => $refundAmount > 0 ? 'refunded' : 'not_refunded',
                ]);

                if ($refundAmount > 0) {
                    $user = $booking->user;
                    if ($user) {
                        $user->wallet_balance += $refundAmount;
                        $user->save();
                        Log::info("Booking #{$booking->id}: Refund {$refundAmount} VND added to user #{$user->id} wallet");
                    }
                }

                DB::commit();
            } catch (\Exception $e) {
                DB::rollBack();
                Log::error("Lỗi xử lý hoàn tiền booking #{$booking->id}: " . $e->getMessage());
            }
        }

        return response()->json([
            'status'  => 'success',
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
            'success'            => true,
            'room_id'            => $room->id,
            'available_quantity' => $room->quantity,
            'room_type'          => $room->room_type,
            'price'              => $room->price,
            'last_updated'       => now()->toISOString()
        ]);
    }
}
