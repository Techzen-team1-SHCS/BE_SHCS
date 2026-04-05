<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class HousekeepingTask extends Model
{
    use HasFactory;

    protected $fillable = [
        'room_number_id',
        'assigned_to',
        'task_type',
        'task_status',
        'priority',
        'scheduled_date',
        'completed_at',
        'notes',
    ];

    protected $casts = [
        'scheduled_date' => 'date',
        'completed_at'   => 'datetime',
    ];

    public function roomNumber()
    {
        return $this->belongsTo(RoomNumber::class, 'room_number_id');
    }

    public function assignedStaff()
    {
        return $this->belongsTo(Staff::class, 'assigned_to');
    }
}
