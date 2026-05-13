<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Http\Controllers\Controller;
use App\Http\Requests\RoomRequest;
use App\Http\Requests\UpdateRoomRequest;
use App\Models\Hotel;
use App\Models\Room;
use App\Models\Scopes\ApprovedScope;
use Auth;
use Illuminate\Http\Request;

class HM_RoomController extends Controller
{
    public function rooms($id)
    {
        $hotel = Hotel::withoutGlobalScope(ApprovedScope::class)->findOrFail($id);

        $this->authorize('viewRoom', $hotel);

        $rooms = $hotel->rooms;

        return response()->json([
            'status' => true,
            'data' => $rooms
        ]);
    }
    public function rooms_all()
    {
        $user = Auth::user();

        $rooms = Room::whereHas('hotel', function ($query) use ($user) {
            $query->withoutGlobalScopes()->where('user_id', $user->id);
        })
        ->with(['hotel' => function($q) {
            $q->select('id', 'name'); 
        }])
        ->latest()
        ->paginate(10);

        return response()->json([
            'status'  => true,
            'message' => 'Danh sách toàn bộ phòng của bạn',
            'data'    => $rooms
        ]);
    }

    public function room_Detail($id)
    {
        // Sửa lỗi gọi with()->get() trên instance làm fetch toàn bộ bảng
        $room = Room::with('roomNumbers')->findOrFail($id);

        return response()->json([
            'status' => true,
            'data'   => $room
        ]);
    }
    public function store_room(RoomRequest $request, $id)
    {
        $hotel = Hotel::withoutGlobalScope(ApprovedScope::class)->findOrFail($id);

        $this->authorize('createRoom', $hotel);

        $data = $request->validated();
        $room = $hotel->rooms()->create($data);

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
        $this->authorize('delete',$room);
        $room->delete();
        return response()->json([
            'status'=>true,
            'message'=>'Xóa phòng thành công'
        ]);
    }


    
}
