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
        Schema::create('payments', function (Blueprint $table) {
            $table->id(); // id bigint unsigned auto_increment
            $table->unsignedBigInteger('booking_id')->index(); // booking_id bigint unsigned index
            $table->enum('method', ['credit', 'paypal', 'momo'])->nullable(); // method enum, nullable
            $table->decimal('amount', 10, 2); // amount decimal(10,2)
            $table->string('transaction_id')->index(); // transaction_id varchar(255) index
            $table->enum('status', ['pending', 'success', 'failed', 'refunded'])->default('pending'); // status enum default pending
            $table->timestamps(); // created_at và updated_at nullable
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('payments');
    }
};
