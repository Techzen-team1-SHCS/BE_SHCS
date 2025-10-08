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
        Schema::create('rates', function (Blueprint $table) {
            $table->id(); // id bigint unsigned auto_increment
            $table->decimal('rate', 2, 1); // rate decimal(2,1)
            $table->unsignedBigInteger('hotel_id')->index(); // hotel_id bigint unsigned index
            $table->unsignedBigInteger('user_id')->index(); // user_id bigint unsigned index
            $table->timestamps(); // created_at và updated_at nullable
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('rates');
    }
};
