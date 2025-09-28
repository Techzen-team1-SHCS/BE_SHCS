<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Hotel_Style extends Model
{
    use HasFactory;
    protected $table='hotel_styles';
    protected $fillable=[
        'hotel_id',
        'style_id'
    ];
    public function hotel()
    {
        return $this->belongsTo(Hotel::class, 'hotel_id');
    }
    public function style()
    {
        return $this->belongsTo(Style::class,'style_id');
    }
}
