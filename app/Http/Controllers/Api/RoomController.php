<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\RoomRequest;
use App\Http\Requests\UpdateRoomRequest;
use App\Models\Booking;
use App\Models\Room;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class RoomController extends Controller
{
    public function index(){
        try {
            $room=Room::all();
            if(!$room){
                return response()->json([
                    'status'=>404,
                    'message'=>'Not found Room about hotel'
                ]);
            }
            return response()->json([
                'status'=>200,
                'data'=>$room
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'error'=>$th->getMessage()
            ]);
        }
    }
    public function getAvailableRooms($hotelId, Request $request)
    {
        $request->validate([
            'checkIn' => 'required|date',
            'checkOut' => 'required|date|after:checkIn',
            'guests' => 'required|integer|min:1'
        ]);

        $checkIn = Carbon::parse($request->checkIn)->startOfDay();
        $checkOut = Carbon::parse($request->checkOut)->endOfDay();
        $guests = $request->guests;

        // 1️⃣ Check phòng phù hợp số người trước
        $rooms = Room::with('roomNumbers') // <-- Thêm dòng này để get kèm RoomNumber
            ->where('hotel_id', $hotelId)
            ->where('availability_status', 'available')
            ->where('max_guest', '>=', $guests)
            ->get();
        if ($rooms->isEmpty()) {
            return response()->json([
                'success' => false,
                'type' => 'OVER_CAPACITY',
                'message' => 'Không có phòng phù hợp với số lượng khách'
            ], 422);
        }

        // 2️⃣ Lọc phòng còn trống theo booking
        $availableRooms = $rooms->filter(function ($room) use ($checkIn, $checkOut) {

            $bookedQuantity = Booking::where('room_id', $room->id)
                ->where('status', '!=', 'cancelled')
                ->where(function ($q) use ($checkIn, $checkOut) {
                    $q->whereBetween('check_in', [$checkIn, $checkOut])
                    ->orWhereBetween('check_out', [$checkIn, $checkOut])
                    ->orWhere(function ($q2) use ($checkIn, $checkOut) {
                        $q2->where('check_in', '<=', $checkIn)
                            ->where('check_out', '>=', $checkOut);
                    });
                })
                ->sum('quantity');

            // Tính số lượng phòng còn lại và gán vào model
            $room->available_quantity = $room->quantity - $bookedQuantity;

            return $room->available_quantity > 0;
        });

        if ($availableRooms->isEmpty()) {
            return response()->json([
                'success' => false,
                'type' => 'NO_ROOM',
                'message' => 'Hết phòng trong khoảng thời gian bạn chọn'
            ], 422);
        }

        return response()->json([
            'success' => true,
            'data' => $availableRooms->values(),
            'total_available' => $availableRooms->count(),
            'search_params' => [
                'checkIn' => $checkIn,
                'checkOut' => $checkOut,
                'guests' => $guests
            ]
        ]);
    }

    public function show($id){
        try {
            $room=Room::with('hotel')->findOrFail($id);
            return response()->json([
                'status'=>200,
                'data'=>$room
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'error'=>$th->getMessage()
            ],500);
        }
    }
    public function store(RoomRequest $request){
        try {
            $room=Room::create($request->validated());
            return response()->json([
                'status'=>200,
                'message'=>'Thêm phòng thành công',
                'data'=>$room
            ]);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'message'=>'Không Thể thêm phòng vui lòng thử lại '
            ]);
        }
    }
    public function update(string $id,UpdateRoomRequest $request){
        try {
            $room=Room::findOrFail($id);
            $room->update($request->validated());
            return response()->json([
                'status'=>200,
                'data'=>$room,
                'message'=>'Cập nhật thông tin thành công'
            ],200);
        } catch (\Throwable $th) {
            Log::error('Lỗi khi cập nhật phòng'. $th->getMessage());
            return response()->json([
                'status'=>500,
                'message'=>'Không thể cập nhật thông tin phòng '
            ]);
        }
    }
    public function destroy($id){
        try {
            $room=Room::findOrFail($id);
            $room->delete();
            return response()->json([
                'status'=>200,
                'data'=>$room,
                'message'=>'Xóa phòng thành công'
            ]);
        } catch (\Throwable $th) {
            Log::error('Lỗi khi xóa phòng'.$th->getMessage());
            return response()->json([
                'status'=>500,
                'message'=>'Không thể xóa phòng'
            ]);
        }
    }

}
