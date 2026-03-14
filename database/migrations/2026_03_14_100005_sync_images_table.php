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
        // Drop old table structure and recreate to match SQL
        // This is safer if the data is not critical, or we can transform it.
        // Given the instructions, we want to match the SQL file exactly.
        
        Schema::dropIfExists('images');
        
        Schema::create('images', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('hotel_id')->nullable();
            $table->unsignedBigInteger('room_id')->nullable();
            $table->string('image_url');
            $table->timestamps();
            
            $table->foreign('hotel_id')->references('id')->on('hotels')->onDelete('cascade');
            $table->foreign('room_id')->references('id')->on('rooms')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('images');
        Schema::create('images', function (Blueprint $table) {
            $table->id();
            $table->string('url');
            $table->string('type');
            $table->unsignedBigInteger('reference_id')->nullable();
            $table->timestamps();
        });
    }
};
