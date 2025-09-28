<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    use HasFactory;

    protected $table = 'bookings';

    protected $fillable = [
        'user_id',
        'room_id',
        'check_in',
        'check_out',
        'total_price',
        'status',
        'payment_status',
        'quantity'
    ];

    protected $casts = [
        'check_in' => 'date',
        'check_out' => 'date',
    ];

    // 🔹 Quan hệ: 1 booking thuộc về 1 user
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    // 🔹 Quan hệ: 1 booking thuộc về 1 room
    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id');
    }
}