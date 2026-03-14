<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('user_behaviors', function (Blueprint $table) {
            // Change action from enum to string
            DB::statement("ALTER TABLE user_behaviors MODIFY COLUMN action VARCHAR(50) NOT NULL");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('user_behaviors', function (Blueprint $table) {
            DB::statement("ALTER TABLE user_behaviors MODIFY COLUMN action ENUM('click', 'search', 'wishlist', 'booking', 'hotels_viewed') NOT NULL");
        });
    }
};
