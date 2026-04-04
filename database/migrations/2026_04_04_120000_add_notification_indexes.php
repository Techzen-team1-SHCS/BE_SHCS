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
        Schema::table('notifications', function (Blueprint $table) {
            // Index cho việc đếm và lọc thông báo chưa đọc
            $table->index(['user_id', 'is_read'], 'idx_notifications_user_unread');
            // Index cho việc lấy danh sách thông báo theo thời gian (latest)
            $table->index(['user_id', 'created_at'], 'idx_notifications_user_created_at');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('notifications', function (Blueprint $table) {
            $table->dropIndex('idx_notifications_user_unread');
            $table->dropIndex('idx_notifications_user_created_at');
        });
    }
};
