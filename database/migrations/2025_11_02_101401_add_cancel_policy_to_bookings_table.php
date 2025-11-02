<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
    {
        Schema::table('bookings', function (Blueprint $table) {
            $table->integer('cancel_free_days')->default(7)->after('total_price');
            $table->decimal('cancel_fee', 15, 2)->nullable()->after('cancel_free_days');
        });
    }

    public function down()
    {
        Schema::table('bookings', function (Blueprint $table) {
            $table->dropColumn(['cancel_free_days', 'cancel_fee']);
        });
    }
};
