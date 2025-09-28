<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class UserBehavior extends Model
{
    use HasFactory;

    protected $table = 'user_behaviors';

    // Dùng timestamps mặc định của Laravel để tracking thời gian
    public $timestamps = true;

    protected $fillable = [
        'user_id',
        'hotel_id',
        'action',
        'metadata',   // chi tiết hành vi dạng JSON
    ];

    protected $casts = [
        'metadata' => 'array',
    ];

    // Quan hệ với user
    public function owner()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }

    public function relatedHotel()
    {
        return $this->belongsTo(\App\Models\Hotel::class, 'hotel_id');
    }

}
