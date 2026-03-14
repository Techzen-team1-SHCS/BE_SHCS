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
        // Kiểm tra xem bảng có các cột cũ không
        if (Schema::hasColumn('discounts', 'room_id')) {
            Schema::table('discounts', function (Blueprint $table) {
                $table->dropColumn(['room_id', 'discount_percent', 'start_date', 'end_date']);
                
                if (!Schema::hasColumn('discounts', 'title')) {
                    $table->string('title')->after('id');
                }
                if (!Schema::hasColumn('discounts', 'code')) {
                    $table->string('code')->unique()->after('title');
                }
                if (!Schema::hasColumn('discounts', 'value')) {
                    $table->string('value')->after('code');
                }
                if (!Schema::hasColumn('discounts', 'minOrder')) {
                    $table->integer('minOrder')->after('value');
                }
                if (!Schema::hasColumn('discounts', 'maxDiscount')) {
                    $table->integer('maxDiscount')->after('minOrder');
                }
                if (!Schema::hasColumn('discounts', 'image')) {
                    $table->string('image')->nullable()->after('maxDiscount');
                }
                if (!Schema::hasColumn('discounts', 'isActive')) {
                    $table->boolean('isActive')->default(true)->after('image');
                }
                if (!Schema::hasColumn('discounts', 'expiryDate')) {
                    $table->date('expiryDate')->after('isActive');
                }
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('discounts', function (Blueprint $table) {
            $columns = ['title', 'code', 'value', 'minOrder', 'maxDiscount', 'image', 'isActive', 'expiryDate'];
            $toDrop = [];
            foreach ($columns as $col) {
                if (Schema::hasColumn('discounts', $col)) $toDrop[] = $col;
            }
            if (!empty($toDrop)) $table->dropColumn($toDrop);
            
            if (!Schema::hasColumn('discounts', 'room_id')) {
                $table->unsignedBigInteger('room_id')->index();
                $table->unsignedTinyInteger('discount_percent');
                $table->date('start_date');
                $table->date('end_date');
            }
        });
    }
};
