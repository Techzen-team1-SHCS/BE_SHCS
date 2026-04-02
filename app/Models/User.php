<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use App\Notifications\Customresetpassword;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;
use Laravel\Reverb\Loggers\Log;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        'name',
        'email',
        'password',
        'phone',
        'role',
        'gender',
        'address',
        'birth',
        'image',
        'wallet_balance',
        'business_license_url',
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
    public function behaviors()
    {
        return $this->hasMany(UserBehavior::class, 'user_id');
    }
    // 🔹 Nếu user có thể tạo khách sạn
    public function hotels()
    {
        return $this->hasMany(Hotel::class, 'user_id');
    }
    public function sendPasswordResetNotification($token)
    {
        $this->notify(new Customresetpassword($token));
    }
    protected static function boot()
    {
        parent::boot();

        // Khi user được update, tự động update tất cả comments
        static::updated(function($user) {
            // Kiểm tra nếu name hoặc avatar thay đổi
            if ($user->isDirty(['name', 'avatar'])) {
                // Update tất cả comments của user này
                \App\Models\Comment::where('userId', $user->id)
                    ->update([
                        'user_name' => $user->name,
                        'user_avatar' => $user->avatar
                    ]);

                // Có thể log lại để debug
                Log::info("Updated comments for user {$user->id} with new name: {$user->name}");
            }
        });
    }
}
