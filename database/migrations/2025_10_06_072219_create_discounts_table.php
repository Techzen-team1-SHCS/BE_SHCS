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
        Schema::create('discounts', function (Blueprint $table) {
            $table->id(); // id bigint unsigned auto_increment
            $table->unsignedBigInteger('room_id')->index(); // room_id bigint unsigned index
            $table->unsignedTinyInteger('discount_percent'); // discount_percent tinyint unsigned
            $table->date('start_date'); // start_date date
            $table->date('end_date'); // end_date date
            $table->enum('status', ['active', 'inactive'])->default('active'); // status enum default active
            $table->timestamps(); // created_at và updated_at nullable
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('discounts');
    }
};
