<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Style extends Model
{
    use HasFactory;
    protected $table='styles';
    protected $fillable=[
        'style'
    ];
    public function hotels()
    {
        return $this->belongsToMany(Hotel::class, 'hotel_styles', 'style_id', 'hotel_id');
    }
}
