<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('user_behaviors', function (Blueprint $table) {
            $table->index('user_id');
            $table->index('hotel_id');
            $table->index('action');
            $table->index('timestamp');
        });
    }

    public function down(): void
    {
        Schema::table('user_behaviors', function (Blueprint $table) {
            $table->dropIndex(['user_id']);
            $table->dropIndex(['hotel_id']);
            $table->dropIndex(['action']);
            $table->dropIndex(['timestamp']);
        });
    }
};
