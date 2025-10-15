<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('rooms', function (Blueprint $table) {
            $table->id();

            $table->foreignId('hotel_id')
                  ->constrained('hotels')
                  ->onDelete('cascade');  // nếu khách sạn xóa thì phòng cũng xóa

            $table->string('room_type');   // tên loại phòng: Deluxe, Standard...
            $table->decimal('price', 10, 2); // giá
            $table->integer('max_guest')->default(1); // số khách tối đa
            $table->integer('quantity')->default(1);  // số lượng phòng loại này

            $table->json('amenities')->nullable();    // tiện nghi (Wifi, TV, ...)
            $table->date('available_from')->nullable();  // ngày bắt đầu khả dụng
            $table->date('available_to')->nullable();    // ngày kết thúc khả dụng

            $table->enum('availability_status', ['available','unavailable'])->default('available');

            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('rooms');
    }
};
