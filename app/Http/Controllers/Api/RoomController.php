<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\RoomRequest;
use App\Http\Requests\UpdateRoomRequest;
use App\Models\Room;
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
