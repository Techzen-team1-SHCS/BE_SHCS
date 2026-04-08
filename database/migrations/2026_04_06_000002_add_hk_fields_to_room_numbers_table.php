<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('room_numbers', function (Blueprint $table) {
            // Trạng thái buồng phòng cho bộ phận Housekeeping
            $table->enum('hk_status', [
                'dirty',        // Bẩn — cần dọn
                'clean',        // Sạch — sẵn sàng đón khách
                'cleaning',     // Đang dọn
                'inspected',    // Đã kiểm tra chất lượng
                'out-of-order', // Hỏng hoặc đang bảo trì
            ])->default('dirty')->after('status');

            // Trạng thái phòng cho bộ phận Lễ tân
            $table->enum('fo_status', [
                'vacant',   // Phòng trống
                'occupied', // Có khách
            ])->default('vacant')->after('hk_status');

            // Cờ "Xin đừng làm phiền" (Do Not Disturb)
            $table->boolean('do_not_disturb')->default(false)->after('fo_status');
        });
    }

    public function down(): void
    {
        Schema::table('room_numbers', function (Blueprint $table) {
            $table->dropColumn(['hk_status', 'fo_status', 'do_not_disturb']);
        });
    }
};
