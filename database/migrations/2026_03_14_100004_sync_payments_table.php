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
        Schema::table('payments', function (Blueprint $table) {
            // Check and rename method to payment_method
            if (Schema::hasColumn('payments', 'method')) {
                $table->renameColumn('method', 'payment_method');
            }
            
            // Add missing columns from SQL
            if (!Schema::hasColumn('payments', 'vnp_txn_ref')) {
                $table->string('vnp_txn_ref', 100)->nullable()->after('status');
            }
            if (!Schema::hasColumn('payments', 'vnp_response_code')) {
                $table->string('vnp_response_code', 10)->nullable()->after('vnp_txn_ref');
            }
            
            // Update status enum
            // Using DB statement for enum update
            \DB::statement("ALTER TABLE payments MODIFY COLUMN status ENUM('pending','paid','failed') DEFAULT 'pending'");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('payments', function (Blueprint $table) {
            if (Schema::hasColumn('payments', 'payment_method')) {
                $table->renameColumn('payment_method', 'method');
            }
            $table->dropColumn(['vnp_txn_ref', 'vnp_response_code']);
            \DB::statement("ALTER TABLE payments MODIFY COLUMN status ENUM('pending', 'success', 'failed', 'refunded') DEFAULT 'pending'");
        });
    }
};
