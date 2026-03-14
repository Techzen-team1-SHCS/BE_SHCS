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
    if (Schema::hasTable('discounts')) {
        Schema::dropIfExists('discounts');
    }
    Schema::create('discounts', function (Blueprint $table) {
        $table->id();
        $table->string('title');
        $table->string('code')->unique();
        $table->string('value'); // ex: "20%"
        $table->integer('minOrder');
        $table->integer('maxDiscount');
        $table->string('image')->nullable();
        $table->boolean('isActive')->default(true);
        $table->date('expiryDate');
        $table->timestamps();
    });
}

public function down()
{
    Schema::dropIfExists('discounts');
}
};
