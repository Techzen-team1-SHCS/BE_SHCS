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
            
            // Update enums - SQLite doesn't support changing enums easily, but this is for MySQL
            DB::statement("ALTER TABLE bookings MODIFY COLUMN status ENUM('pending','confirmed','cancelled','completed') NOT NULL DEFAULT 'pending'");
            DB::statement("ALTER TABLE bookings MODIFY COLUMN payment_status ENUM('paid','unpaid','refunded','not_refunded') NOT NULL DEFAULT 'unpaid'");

            // Add indexes
            $table->index('status', 'idx_booking_status');
            $table->index('created_at', 'idx_booking_created_at');
            $table->index('created_at', 'idx_bookings_created_at');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('bookings', function (Blueprint $table) {
            $table->dropIndex('idx_booking_status');
            $table->dropIndex('idx_booking_created_at');
            $table->dropIndex('idx_bookings_created_at');
            $table->dropColumn('quantity');
            DB::statement("ALTER TABLE bookings MODIFY COLUMN status ENUM('pending', 'confirmed', 'canceled') NOT NULL DEFAULT 'pending'");
            DB::statement("ALTER TABLE bookings MODIFY COLUMN payment_status ENUM('paid', 'unpaid', 'refunded') NOT NULL DEFAULT 'unpaid'");
        });
    }
};
