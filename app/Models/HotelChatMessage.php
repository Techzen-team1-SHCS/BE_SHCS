<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HotelChatMessage extends Model
{
    use HasFactory;

    protected $table = 'hotel_chat_messages';
    protected $fillable = [
        'thread_id',
        'sender_type',
        'sender_id',
        'content',
        'type',
    ];

    public function thread()
    {
        return $this->belongsTo(HotelChatThread::class, 'thread_id');
    }
}
