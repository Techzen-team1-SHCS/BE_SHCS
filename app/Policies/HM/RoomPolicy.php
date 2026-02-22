<?php

namespace App\Policies\HM;

use App\Models\Room;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class RoomPolicy
{
    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        //
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, Room $room): bool
    {
        //
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        //
    }

    /**
     * Determine whether the user can update the model.
     */
    // Cập nhật room
    public function update(User $user, Room $room)
    {
        return $user->role === 2 && $room->hotel->user_id === $user->id
            ? Response::allow()
            : Response::deny('Bạn không có quyền cập nhật room này');
    }

    // Xóa room
    public function delete(User $user, Room $room)
    {
        return $user->role === 2 && $room->hotel->user_id === $user->id
            ? Response::allow()
            : Response::deny('Bạn không có quyền xóa room này');
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, Room $room): bool
    {
        //
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, Room $room): bool
    {
        //
    }
}
