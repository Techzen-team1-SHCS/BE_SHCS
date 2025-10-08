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
            $table->id(); // id bigint unsigned auto_increment
            $table->unsignedBigInteger('user_id')->index(); // user_id bigint unsigned index
            $table->unsignedBigInteger('room_id')->index(); // room_id bigint unsigned index
            $table->date('check_in'); // check_in date
            $table->date('check_out'); // check_out date
            $table->decimal('total_price', 10, 2); // total_price decimal(10,2)
            $table->enum('status', ['pending', 'confirmed', 'canceled'])->default('pending'); // status enum
            $table->enum('payment_status', ['paid', 'unpaid', 'refunded'])->default('unpaid'); // payment_status enum
            $table->timestamps(); // created_at và updated_at
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
