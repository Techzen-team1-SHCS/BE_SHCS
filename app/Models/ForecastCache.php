<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ForecastCache extends Model
{
    use HasFactory;

    protected $table = 'forecast_caches';

    protected $fillable = [
        'hotel_id',
        'hotel_ref',
        'hotel_capacity',
        'horizon_days',
        'mode',
        'payload_sent',
        'ai_result',
    ];

    protected $casts = [
        'payload_sent' => 'array',
        'ai_result' => 'array',
    ];
}
