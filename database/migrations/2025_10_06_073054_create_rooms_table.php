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
            $table->id(); // id bigint unsigned auto_increment
            $table->unsignedBigInteger('hotel_id')->index(); // hotel_id bigint unsigned index
            $table->string('room_type'); // room_type varchar(255)
            $table->decimal('price', 10, 2); // price decimal(10,2)
            $table->integer('capacity'); // capacity int
            $table->json('amenties')->nullable(); // amenties json nullable
            $table->enum('availability_status', ['available', 'booked', 'maintenance']); // availability_status enum
            $table->timestamps(); // created_at và updated_at nullable
            $table->integer('quantity'); // quantity int
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
