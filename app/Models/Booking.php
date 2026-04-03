<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    use HasFactory;

    protected $table = 'bookings';

    protected $fillable = [
        'user_id',
        'room_id',
        'check_in',
        'check_out',
        'total_price',
        'status',
        'quantity',
        'selected_room_numbers',
        'payment_status',
        'cancel_free_days',
        'discount_code',
        'discount_amount',
        'final_price'
    ];

    protected $casts = [
        'check_in' => 'date',
        'check_out' => 'date',
    ];

    // 🔹 Quan hệ: 1 booking thuộc về 1 user
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
     public function payments()
    {
        return $this->hasMany(Payment::class, 'booking_id', 'id');
    }

    // 🔹 Quan hệ: 1 booking thuộc về 1 room
    public function room()
    {
        return $this->belongsTo(Room::class, 'room_id');
    }


    public function getOrGeneratePaymentCode()
    {
        if ($this->payment_code) {
            return $this->payment_code;
        }
        $dayOfWeek = strtoupper(substr(now()->format('l'), 0, 2)); 
        
        /* Kết quả sẽ tự động ra:
        - Thứ 2: MO
        - Thứ 3: TU
        - Thứ 4: WE
        - Thứ 5: TH
        - Thứ 6: FR
        - Thứ 7: SA
        - Chủ nhật: SU
        */

        // 3. Lấy Ngày và Tháng
        $day = now()->format('d');
        $month = now()->format('m');

        // 4. Ghép toàn bộ lại: [MÃ THỨ] + [NGÀY] + [THÁNG] + [ID ĐƠN]
        $newCode = $dayOfWeek . $day . $month . $this->id;

        // 5. Lưu vào Database
        $this->update(['payment_code' => $newCode]);

        return $newCode;
    }
}
