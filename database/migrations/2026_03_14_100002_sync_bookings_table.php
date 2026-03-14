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
        Schema::table('bookings', function (Blueprint $table) {
            if (!Schema::hasColumn('bookings', 'quantity')) {
                $table->integer('quantity')->nullable()->after('room_id');
            }
        });

        // Update enums
        DB::statement("ALTER TABLE bookings MODIFY COLUMN status ENUM('pending','confirmed','cancelled','completed') NOT NULL DEFAULT 'pending'");
        DB::statement("ALTER TABLE bookings MODIFY COLUMN payment_status ENUM('paid','unpaid','refunded','not_refunded') NOT NULL DEFAULT 'unpaid'");

        // Add indexes safely
        $this->addIndexIfNotExists('bookings', 'status', 'idx_booking_status');
        $this->addIndexIfNotExists('bookings', 'created_at', 'idx_booking_created_at');
        $this->addIndexIfNotExists('bookings', 'created_at', 'idx_bookings_created_at');
    }

    private function addIndexIfNotExists($table, $column, $indexName)
    {
        $indexes = DB::select("SHOW INDEX FROM {$table} WHERE Key_name = '{$indexName}'");
        if (empty($indexes)) {
            Schema::table($table, function (Blueprint $table) use ($column, $indexName) {
                $table->index($column, $indexName);
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Sửa dữ liệu trước khi rollback enum để tránh lỗi "Data truncated"
        DB::table('bookings')->where('status', 'cancelled')->update(['status' => 'canceled']);
        DB::table('bookings')->where('status', 'completed')->update(['status' => 'pending']);
        DB::table('bookings')->where('payment_status', 'not_refunded')->update(['payment_status' => 'unpaid']);

        Schema::table('bookings', function (Blueprint $table) {
            $this->dropIndexIfExists('bookings', 'idx_booking_status');
            $this->dropIndexIfExists('bookings', 'idx_booking_created_at');
            $this->dropIndexIfExists('bookings', 'idx_bookings_created_at');
            
            if (Schema::hasColumn('bookings', 'quantity')) {
                $table->dropColumn('quantity');
            }
            DB::statement("ALTER TABLE bookings MODIFY COLUMN status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending'");
            DB::statement("ALTER TABLE bookings MODIFY COLUMN payment_status ENUM('paid', 'unpaid', 'refunded') NOT NULL DEFAULT 'unpaid'");
        });
    }

    private function dropIndexIfExists($table, $indexName)
    {
        $indexes = DB::select("SHOW INDEX FROM {$table} WHERE Key_name = '{$indexName}'");
        if (!empty($indexes)) {
            Schema::table($table, function (Blueprint $table) use ($indexName) {
                $table->dropIndex($indexName);
            });
        }
    }
};
