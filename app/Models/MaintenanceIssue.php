<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MaintenanceIssue extends Model
{
    use HasFactory;

    protected $fillable = [
        'room_number_id',
        'reported_by',
        'description',
        'issue_status',
        'image_url',
    ];

    public function roomNumber()
    {
        return $this->belongsTo(RoomNumber::class, 'room_number_id');
    }

    public function reportedBy()
    {
        return $this->belongsTo(Staff::class, 'reported_by');
    }
}
