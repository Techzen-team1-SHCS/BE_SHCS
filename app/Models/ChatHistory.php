<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ChatHistory extends Model
{
    use HasFactory;

    protected $fillable = [
        'session_id',
        'sender',
        'text',
        'hotels'
    ];

    protected $casts = [
        'hotels' => 'array'
    ];
}
