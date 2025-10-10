<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;

use App\Notifications\Customresetpassword;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Passport\HasApiTokens;
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

    // 🔹 Quan hệ với Image (ảnh đại diện hoặc avatar user)
    public function images()
    {
        return $this->hasMany(Image::class, 'reference_id')
                    ->where('type', 'avatar');
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
}
