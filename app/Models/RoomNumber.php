<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RoomNumber extends Model
{
    use HasFactory;

    protected $table = 'room_numbers';

    protected $fillable = [
        'room_id',
        'room_number',
        'status',
        'hk_status',
        'fo_status',
        'do_not_disturb',
    ];

    protected $casts = [
        'do_not_disturb' => 'boolean',
    ];

    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id');
    }

    public function housekeepingTasks()
    {
        return $this->hasMany(HousekeepingTask::class, 'room_number_id');
    }

    public function housekeepingLogs()
    {
        return $this->hasMany(HousekeepingLog::class, 'room_number_id');
    }

    public function maintenanceIssues()
    {
        return $this->hasMany(MaintenanceIssue::class, 'room_number_id');
    }
}
