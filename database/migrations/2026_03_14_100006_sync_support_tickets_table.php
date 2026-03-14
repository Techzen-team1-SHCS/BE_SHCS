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
        Schema::table('support_tickets', function (Blueprint $table) {
            // 1. Xóa user_id nếu đã lỡ tạo ở các version sync trước
            if (Schema::hasColumn('support_tickets', 'user_id')) {
                // Thử drop foreign key nếu có (thường là support_tickets_user_id_foreign)
                try {
                    $table->dropForeign(['user_id']);
                } catch (\Exception $e) {
                    // Foreign key might not exist
                }
                $table->dropColumn('user_id');
            }

            // 2. Khôi phục các cột bị thiếu nếu đã lỡ bị xóa
            if (!Schema::hasColumn('support_tickets', 'name')) {
                $table->string('name')->after('id');
            }
            if (!Schema::hasColumn('support_tickets', 'email')) {
                $table->string('email')->after('name');
            }
            if (!Schema::hasColumn('support_tickets', 'priority')) {
                $table->enum('priority', ['low', 'medium', 'high', 'urgent'])->default('medium')->after('subject');
            }
            if (!Schema::hasColumn('support_tickets', 'ticket_number')) {
                $table->string('ticket_number')->unique()->after('status');
            }

            // 3. Đảm bảo enum status là chính xác
            // Sử dụng DB statement cho MySQL để cập nhật ENUM nếu cần
            try {
                DB::statement("ALTER TABLE support_tickets MODIFY COLUMN status ENUM('pending','in_progress','resolved') NOT NULL DEFAULT 'pending'");
            } catch (\Exception $e) {
                // May fail on some DB drivers, ignore if already correct
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Không làm gì vì chúng ta đang khôi phục về version gốc
    }
};
