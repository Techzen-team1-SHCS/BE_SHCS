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
        Schema::table('payments', function (Blueprint $table) {
            // 1. Cột user_id (BigInt UNSIGNED, Nullable)
            if (!Schema::hasColumn('payments', 'user_id')) {
                $table->unsignedBigInteger('user_id')->nullable()->after('id');
            }

            // 2. Cột booking_id (BigInt, Not Null) - Đảm bảo kiểu dữ liệu khớp
            if (Schema::hasColumn('payments', 'booking_id')) {
                $table->bigInteger('booking_id')->change();
            }

            // 3. Cột amount (Decimal 10,2, Not Null)
            if (Schema::hasColumn('payments', 'amount')) {
                $table->decimal('amount', 10, 2)->change();
            }

            // 4. Cột payment_method (Varchar 50, Default 'vnpay', Not Null)
            if (Schema::hasColumn('payments', 'method')) {
                $table->renameColumn('method', 'payment_method');
            }
            
            // Chỉnh sửa thuộc tính cột payment_method sau khi rename hoặc nếu đã có
            $table->string('payment_method', 50)->default('vnpay')->change();

            // 5. Các cột vnpay
            if (!Schema::hasColumn('payments', 'vnp_txn_ref')) {
                $table->string('vnp_txn_ref', 100)->nullable()->after('status');
            }
            if (!Schema::hasColumn('payments', 'vnp_response_code')) {
                $table->string('vnp_response_code', 10)->nullable()->after('vnp_txn_ref');
            }

            // 6. Xóa các cột không có trong SQL mới
            if (Schema::hasColumn('payments', 'transaction_id')) {
                $table->dropColumn('transaction_id');
            }
        });

        // 7. Cập nhật ENUM status (pending, paid, failed)
        try {
            DB::statement("ALTER TABLE payments MODIFY COLUMN status ENUM('pending','paid','failed') DEFAULT 'pending'");
        } catch (\Exception $e) {}
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            // Rollback các thay đổi quan trọng nếu cần
            if (Schema::hasColumn('payments', 'payment_method')) {
                $table->renameColumn('payment_method', 'method');
            }
            
            if (!Schema::hasColumn('payments', 'transaction_id')) {
                $table->string('transaction_id')->nullable();
            }
        });
    }
};
