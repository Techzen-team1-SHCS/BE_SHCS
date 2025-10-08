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
        Schema::create('user_behaviors', function (Blueprint $table) {
            $table->id(); // id bigint unsigned auto_increment
            $table->unsignedBigInteger('user_id')->nullable()->index(); // user_id bigint unsigned nullable index
            $table->unsignedBigInteger('hotel_id')->nullable()->index(); // hotel_id bigint unsigned nullable index
            $table->enum('action', ['click', 'search', 'wishlist', 'booking', 'hotels_viewed'])->index(); // action enum index
            $table->json('metadata')->nullable(); // metadata json nullable
            $table->timestamp('timestamp')->useCurrent()->index(); // timestamp default CURRENT_TIMESTAMP index
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_behaviors');
    }
};
