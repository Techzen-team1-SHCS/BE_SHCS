<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SupportTicket extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'email',
        'subject',
        'priority',
        'message',
        'status',
        'ticket_number'
    ];

    protected static function boot()
    {
        parent::boot();

        static::creating(function ($ticket) {
            $ticket->ticket_number = 'TKT-' . date('Ymd') . '-' . str_pad(rand(1, 9999), 4, '0', STR_PAD_LEFT);
        });
    }

    // Relationship với user (nếu có)
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
