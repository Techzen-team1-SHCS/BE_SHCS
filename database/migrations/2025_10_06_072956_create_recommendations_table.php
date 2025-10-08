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
        Schema::create('recommendations', function (Blueprint $table) {
            $table->id(); // id bigint unsigned auto_increment
            $table->unsignedBigInteger('user_id')->index(); // user_id bigint unsigned index
            $table->unsignedBigInteger('hotel_id')->index(); // hotel_id bigint unsigned index
            $table->decimal('score', 5, 2); // score decimal(5,2)
            $table->timestamp('created_at')->useCurrent(); // created_at timestamp default CURRENT_TIMESTAMP
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('recommendations');
    }
};
