<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HotelChatThread extends Model
{
    use HasFactory;

    protected $table = 'hotel_chat_threads';
    protected $fillable = [
        'hotel_id',
        'user_id',
        'hm_id',
        'status',
        'last_message',
        'hm_unread_count',
        'hm_last_read_at',
    ];

    public function hotel()
    {
        return $this->belongsTo(Hotel::class, 'hotel_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function hm()
    {
        return $this->belongsTo(User::class, 'hm_id');
    }

    public function messages()
    {
        return $this->hasMany(HotelChatMessage::class, 'thread_id')->orderBy('created_at');
    }
}
