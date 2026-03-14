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
        Schema::table('images', function (Blueprint $table) {
            // Nếu có cột image_url thì đổi tên lại thành url
            if (Schema::hasColumn('images', 'image_url') && !Schema::hasColumn('images', 'url')) {
                $table->renameColumn('image_url', 'url');
            }

            // Nếu không có url thì tạo mới
            if (!Schema::hasColumn('images', 'url')) {
                $table->string('url')->nullable()->after('id');
            }

            // Đảm bảo có cột 'type' và 'reference_id'
            if (!Schema::hasColumn('images', 'type')) {
                $table->string('type')->nullable()->after('url');
            }

            if (!Schema::hasColumn('images', 'reference_id')) {
                $table->unsignedBigInteger('reference_id')->nullable()->after('type');
            }

            // Xóa các cột thừa nếu đã lỡ tạo ở các lần migrate trước
            if (Schema::hasColumn('images', 'hotel_id')) {
                $table->dropForeign(['hotel_id']);
                $table->dropColumn('hotel_id');
            }
            if (Schema::hasColumn('images', 'room_id')) {
                $table->dropForeign(['room_id']);
                $table->dropColumn('room_id');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('images', function (Blueprint $table) {
            // Không thực hiện gì đặc biệt khi rollback để giữ cấu trúc gốc
        });
    }
};
