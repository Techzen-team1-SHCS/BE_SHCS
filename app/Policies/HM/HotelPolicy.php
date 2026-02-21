<?php

namespace App\Policies\HM;

use App\Models\Hotel;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class HotelPolicy
{
    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user)
    {
        return $user->role === 2
            ? Response::allow()
            : Response::deny('Bạn không có quyền truy cập');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, Hotel $hotel)
    {
        return $user->role === 2 && $hotel->user_id === $user->id
        ? Response::allow()
        : Response::deny('Bạn không có quyền truy cập');
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user)
    {
        return $user->role === 2
            ? Response::allow()
            : Response::deny('Bạn không có quyền tạo khách sạn');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, Hotel $hotel)
    {
        return $user->role === 2 && $hotel->user_id === $user->id
        ? Response::allow()
        : Response::deny('Bạn không có quyền truy cập');
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Hotel $hotel)
    {
        return $user->role === 2 && $hotel->user_id === $user->id
        ? Response::allow()
        : Response::deny('Bạn không có quyền truy cập');
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, Hotel $hotel): bool
    {
        //
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, Hotel $hotel): bool
    {
        //
    }
}
