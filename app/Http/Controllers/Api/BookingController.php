<?php

namespace App\Http\Controllers\Api;

use App\Events\BookingCreated;
use App\Events\RoomQuantityUpdated;
use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Room;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

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
            'status' => ['sometimes', Rule::in(['pending','confirmed','cancelled'])]
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
            $booking = Booking::with('room')->find($id);

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

            // 🕒 Tính toán chính sách hủy
            $checkIn = Carbon::parse($booking->check_in);
            $now = Carbon::now();
            $cancelFreeDays = $booking->cancel_free_days ?? 3; // default 7 ngày
            $freeUntil = $checkIn->copy()->subDays($cancelFreeDays)->endOfDay();

            $cancelFee = 0;
            $isFree = true;

            // Nếu hủy sau thời hạn miễn phí
            if ($now->greaterThan($freeUntil)) {
                $isFree = false;
                // Phạt 1 đêm (tùy bạn, có thể thay = $booking->total_price)
                $cancelFee = $booking->total_price / ($booking->nights ?? 1);
            }

            // 🔒 LOCK room (giống code cũ)
            $room = Room::where('id', $booking->room_id)
                ->lockForUpdate()
                ->first();

            // Khôi phục số lượng phòng
            $room->increment('quantity', $booking->quantity);
            $newQuantity = $room->fresh()->quantity;

            // Cập nhật trạng thái booking + phí hủy
            $booking->update([
                'status' => 'cancelled',
                'cancel_fee' => $cancelFee,
                'cancelled_at' => now()
            ]);

            DB::commit();

            // 📢 Broadcast realtime updates (giữ nguyên)
            event(new RoomQuantityUpdated($room->id, $newQuantity, 'cancelled', $booking->id));

            return response()->json([
                'success' => true,
                'message' => $isFree
                    ? 'Hủy phòng thành công, không mất phí.'
                    : 'Hủy phòng thành công, bị phạt ' . number_format($cancelFee, 0, ',', '.') . ' VND.',
                'data' => [
                    'booking' => $booking->load(['user', 'room']),
                    'cancel_fee' => $cancelFee,
                    'is_free' => $isFree,
                    'free_until' => $freeUntil->format('H:i d/m/Y'),
                    'available_quantity' => $newQuantity,
                ]
            ]);

        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => 'Failed to cancel booking',
                'error' => $e->getMessage()
            ], 500);
        }
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
