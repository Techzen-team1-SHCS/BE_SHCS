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
        // If the table was created by the old migration, we need to transform it
        if (Schema::hasColumn('discounts', 'room_id')) {
            Schema::table('discounts', function (Blueprint $table) {
                $table->dropColumn(['room_id', 'discount_percent', 'start_date', 'end_date']);
                
                $table->string('title')->after('id');
                $table->string('code')->unique()->after('title');
                $table->string('value')->after('code');
                $table->integer('minOrder')->after('value');
                $table->integer('maxDiscount')->after('minOrder');
                $table->string('image')->nullable()->after('maxDiscount');
                $table->boolean('isActive')->default(true)->after('image');
                $table->date('expiryDate')->after('isActive');
            });
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('discounts', function (Blueprint $table) {
            $table->dropColumn(['title', 'code', 'value', 'minOrder', 'maxDiscount', 'image', 'isActive', 'expiryDate']);
            
            $table->unsignedBigInteger('room_id')->index();
            $table->unsignedTinyInteger('discount_percent');
            $table->date('start_date');
            $table->date('end_date');
        });
    }
};
