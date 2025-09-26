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
        Schema::create('rooms', function (Blueprint $table) {
            $table->id();
            $table->foreignId('hotel_id')->constrained('hotels')->onDelete('cascade');//Khóa ngoại đến hotels
            $table->string('room_type');//vd:Deluxe
            $table->decimal('price',10,2);//Giá phòng
            $table->integer('capacity');//sức chứa
            $table->json('amenties')->nullable();//Tiện ích Json:wifi,ac,tv...
            $table->enum('availability_status',['available','booked','maintenance']);
            $table->timestamps();

        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rooms');
    }
};
