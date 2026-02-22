<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Http\Controllers\Controller;
use App\Http\Requests\RoomRequest;
use App\Http\Requests\UpdateRoomRequest;
use App\Models\Hotel;
use App\Models\Room;
use Illuminate\Http\Request;

class HM_RoomController extends Controller
{
    public function rooms($id)
    {
        $hotel = Hotel::findOrFail($id);

        $this->authorize('viewRooms', $hotel);

        $rooms = $hotel->rooms;

        return response()->json([
            'status' => true,
            'data' => $rooms
        ]);
    }
    public function store_room(RoomRequest $request, $id)
    {
        $hotel = Hotel::findOrFail($id);

        $this->authorize('createRoom', $hotel);

        $data = $request->validated();
        $data['hotel_id'] = $hotel->id;

        $room = Room::create($data);

        return response()->json([
            'status' => true,
            'message' => 'Thêm phòng thành công',
            'data' => $room
        ]);
    }
    public function update_room($id, UpdateRoomRequest $request)
    {
        $room = Room::findOrFail($id);

        $this->authorize('update', $room);

        $room->update($request->validated());

        return response()->json([
            'status' => true,
            'message' => 'Cập nhật phòng thành công',
            'data' => $room
        ]);
    }
    public function delete_room($id)
    {
        $room=Room::findOrFail($id);
        $this->delete('delete',$room);
        $room->delete();
        return response()->json([
            'status'=>true,
            'message'=>'Xóa phòng thành công'
        ]);
    }
    
}
