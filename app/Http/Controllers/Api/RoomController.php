<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\RoomRequest;
use App\Http\Requests\UpdateRoomRequest;
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
        try {
            $request->validate([
                'checkIn' => 'required|date',
                'checkOut' => 'required|date|after:checkIn',
                'guests' => 'nullable|integer|min:1'
            ]);

            $checkIn = Carbon::parse($request->checkIn)->startOfDay();
            $checkOut = Carbon::parse($request->checkOut)->endOfDay();
            $guests = $request->guests ?? 1;

            // Lấy phòng available với điều kiện
            $availableRooms = Room::where('hotel_id', $hotelId)
                ->where('availability_status', 'available')
                ->where('max_guest', '>=', $guests)
                ->where('quantity', '>', 0) // Còn phòng trống
                ->where(function($query) use ($checkIn, $checkOut) {
                    // Check available_from và available_to nếu có
                    $query->where(function($q) use ($checkIn, $checkOut) {
                        $q->whereNull('available_from')
                          ->orWhere('available_from', '<=', $checkIn);
                    })->where(function($q) use ($checkIn, $checkOut) {
                        $q->whereNull('available_to')
                          ->orWhere('available_to', '>=', $checkOut);
                    });
                })
                ->with('hotel') // Eager load hotel info nếu cần
                ->get();
           
            return response()->json([
                'success' => true,
                'data' => $availableRooms,
                'total_available' => $availableRooms->count(),
                'search_params' => [
                    'checkIn' => $checkIn,
                    'checkOut' => $checkOut,
                    'guests' => $guests
                ]
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error fetching available rooms: ' . $e->getMessage()
            ], 500);
        }
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
            Log::error("Lỗi khi thêm phòng".$th->getMessage());
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
