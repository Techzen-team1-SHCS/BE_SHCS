<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Hotel extends Model
{
    use HasFactory;
    protected $table='hotels';
    protected $fillable=[
        'name','province','description','price','name_nearby_place','hotel_class','text','amenities'
    ];
    protected $casts = [
        'amenities' => 'array',
    ];
    public function rooms()
    {
        return $this->hasMany(Room::class, 'hotel_id');
    }
    public function bookings()
    {
        return $this->hasManyThrough(Booking::class, Room::class, 'hotel_id', 'room_id');
    }
    public function comments()
    {
        return $this->hasMany(Comment::class, 'maHotel');
    }


    // Một khách sạn có nhiều phong cách (qua bảng trung gian hotel_styles)
    public function styles()
    {
        return $this->belongsToMany(Style::class, 'hotel_styles', 'hotel_id', 'style_id');
    }

    // Một khách sạn có nhiều ảnh
    public function images()
    {
        return $this->hasMany(Image::class, 'reference_id')
                    ->where('type', 'hotel');
    }

    // Một khách sạn có nhiều hành vi người dùng
    public function behaviors()
    {
        return $this->hasMany(UserBehavior::class, 'hotel_id');
    }
    public function getPriceFormattedAttribute()
    {
        return number_format($this->attributes['price'], 0, ',', '.');
    }

}
