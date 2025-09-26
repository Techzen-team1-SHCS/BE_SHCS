<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();

            // Khóa ngoại tới bảng users
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');

            // Khóa ngoại tới bảng rooms
            $table->foreignId('room_id')->constrained('rooms')->onDelete('cascade');

            // Ngày nhận - trả phòng
            $table->date('check_in');
            $table->date('check_out');

            // Tổng giá (giữ 2 chữ số thập phân)
            $table->decimal('total_price', 10, 2);

            // Trạng thái đặt phòng: pending (chờ), confirmed (xác nhận), canceled (hủy)
            $table->enum('status', ['pending', 'confirmed', 'canceled'])->default('pending');

            // Trạng thái thanh toán: paid, unpaid, refunded
            $table->enum('payment_status', ['paid', 'unpaid', 'refunded'])->default('unpaid');

            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('bookings');
    }
};
