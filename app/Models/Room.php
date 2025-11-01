<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Room extends Model
{
    use HasFactory;
    protected $table='rooms';
    protected $casts = [
    'amenities' => 'array', // tự cast JSON ↔ array
    ];
    protected $fillable=[
        'hotel_id',
        'room_type',         // loại phòng: Deluxe, Standard
        'price',             // giá
        'max_guest',         // số khách tối đa
        'quantity',          // số lượng phòng
        'amenities',         // tiện nghi (JSON hoặc CSV)
        'available_from',    // ngày bắt đầu khả dụng
        'available_to',      // ngày kết thúc khả dụng
        'availability_status' // optional: "available", "unavailable"
    ];
    public function hotel()
    {
        return $this->belongsTo(Hotel::class, 'hotel_id');
    }
    public function bookings()
    {
        return $this->hasMany(Booking::class, 'room_id');
    }
     public function isAvailable($requiredQuantity = 1): bool
    {
        return $this->quantity >= $requiredQuantity &&
               $this->availability_status === 'available';
    }

    /**
     * Giảm số lượng phòng (realtime)
     */
    public function reduceQuantity($quantity): bool
    {
        if ($this->quantity < $quantity) {
            return false;
        }

        $this->decrement('quantity', $quantity);
        return true;
    }

    /**
     * Khôi phục số lượng phòng (realtime)
     */
    public function restoreQuantity($quantity): bool
    {
        $this->increment('quantity', $quantity);
        return true;
    }
}
