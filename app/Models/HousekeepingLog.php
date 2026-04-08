<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HousekeepingLog extends Model
{
    public $timestamps = false;

    protected $fillable = [
        'room_number_id',
        'changed_by',
        'old_status',
        'new_status',
        'changed_at',
    ];

    protected $casts = [
        'changed_at' => 'datetime',
    ];

    public function roomNumber()
    {
        return $this->belongsTo(RoomNumber::class, 'room_number_id');
    }

    public function changedBy()
    {
        return $this->belongsTo(Staff::class, 'changed_by');
    }
}
