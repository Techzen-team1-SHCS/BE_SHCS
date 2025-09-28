<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Hotel extends Model
{
    use HasFactory;
    protected $table='hotels';
    protected $fillable=[
        'name','province','description','price','name_nearby_place','hotel_class'
    ];
    public function rooms()
    {
        return $this->hasMany(Room::class, 'hotel_id');
    }

    // Một khách sạn có nhiều phong cách (qua bảng trung gian hotel_styles)
    public function styles()
    {
        return $this->belongsToMany(Style::class, 'hotel_styles', 'hotel_id', 'style_id');
    }

    // Một khách sạn có nhiều ảnh
    public function images()
    {
        return $this->morphMany(Image::class, 'reference');
    }

    // Một khách sạn có nhiều hành vi người dùng
    public function behaviors()
    {
        return $this->hasMany(UserBehavior::class, 'hotel_id');
    }
}
