<?php

namespace App\Policies\HM;

use App\Models\Room;
use App\Models\RoomNumber;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class RoomNumberPolicy
{
    /**
     * Quyền tạo room_number cho 1 room (bulk generate).
     */
    public function create(User $user, RoomNumber $roomNumber)
    {
        $room = $roomNumber->room ?? null;
        if (!$room instanceof Room) {
            return Response::deny('Không tìm thấy room để tạo room_number');
        }

        $hotel = $room->hotel ?? null;
        if (!$hotel) {
            return Response::deny('Không tìm thấy hotel của room');
        }

        return $user->role === 2 && $hotel->user_id === $user->id
            ? Response::allow()
            : Response::deny('Bạn không có quyền tạo room_number cho room này');
    }

    /**
     * Quyền cập nhật room_number (đổi status / thông tin).
     */
    public function update(User $user, RoomNumber $roomNumber)
    {
        $room = $roomNumber->room ?? null;
        if (!$room instanceof Room) {
            return Response::deny('Không tìm thấy room để cập nhật');
        }

        $hotel = $room->hotel ?? null;
        if (!$hotel) {
            return Response::deny('Không tìm thấy hotel của room');
        }

        return $user->role === 2 && $hotel->user_id === $user->id
            ? Response::allow()
            : Response::deny('Bạn không có quyền cập nhật room_number này');
    }

    /**
     * Quyền xóa room_number.
     */
    public function delete(User $user, RoomNumber $roomNumber)
    {
        $room = $roomNumber->room ?? null;
        if (!$room instanceof Room) {
            return Response::deny('Không tìm thấy room để xóa');
        }

        $hotel = $room->hotel ?? null;
        if (!$hotel) {
            return Response::deny('Không tìm thấy hotel của room');
        }

        return $user->role === 2 && $hotel->user_id === $user->id
            ? Response::allow()
            : Response::deny('Bạn không có quyền xóa room_number này');
    }
}

