<?php

namespace App\Models;

use App\Models\Scopes\ApprovedScope;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Hotel extends Model
{
    protected static function booted()
    {
        static::addGlobalScope(new ApprovedScope);
    }
    use HasFactory;
    protected $table = 'hotels';
    protected $fillable = [
        'name',
        'province',
        'description',
        'price',
        'name_nearby_place',
        'hotel_class',
        'text',
        'amenities',
        'user_id',
        'status'
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
        return $this->hasManyThrough(
            Booking::class,
            Room::class,
            'hotel_id', // rooms.hotel_id
            'room_id',  // bookings.room_id
            'id',       // hotels.id
            'id'        // rooms.id
        );
    }
    public function comments()
    {
        return $this->hasMany(Comment::class, 'maHotel');
    }
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
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
    public function roomNumbers()
    {
        return $this->hasManyThrough(
            \App\Models\RoomNumber::class, // Model đích muốn lấy
            \App\Models\Room::class        // Model trung gian
        );
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
    public function firstimage()
    {
        return $this->hasOne(Image::class, 'reference_id')
            ->orderBy('id', 'desc');
    }
    public function firstroom()
    {
        return $this->hasOne(Room::class, 'hotel_id')
            ->where('quantity', '>', 0)
            ->orderBy('available_from', 'asc');
    }
}
