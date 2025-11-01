<?php

namespace App\Http\Controllers\Api;

use App\Events\BookingCreated;
use App\Events\RoomQuantityUpdated;
use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Room;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class BookingController extends Controller
{
    public function index(){
        $bookings=Booking::with(['user','room'])->orderBy('created_at','desc')->get();
        return response()->json(['data'=>$bookings]);
    }
    public function show($id){
        $booking=Booking::with(['user','room'])->findOrFail($id);
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

            // 🔒 LOCK room
            $room = Room::where('id', $booking->room_id)
                ->lockForUpdate()
                ->first();

            // Khôi phục số lượng phòng
            $room->increment('quantity', $booking->quantity);
            $newQuantity = $room->fresh()->quantity;

            // Cập nhật trạng thái booking
            $booking->update(['status' => 'cancelled']);

            DB::commit();

            // 📢 Broadcast realtime updates
            event(new RoomQuantityUpdated($room->id, $newQuantity, 'cancelled', $booking->id));

            return response()->json([
                'success' => true,
                'message' => 'Booking cancelled successfully',
                'data' => $booking->load(['user', 'room']),
                'available_quantity' => $newQuantity
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
