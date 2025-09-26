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
            $table->id();

            // Gắn với booking
            $table->foreignId('booking_id')->constrained('bookings')->onDelete('cascade');

            // Phương thức thanh toán: credit, paypal, momo...
            $table->enum('method', ['credit', 'paypal', 'momo'])->nullable();

            // Số tiền thanh toán
            $table->decimal('amount', 10, 2);

            // Mã giao dịch từ cổng thanh toán
            $table->string('transaction_id')->unique();

            // Trạng thái giao dịch
            $table->enum('status', ['pending', 'success', 'failed', 'refunded'])->default('pending');

            $table->timestamps();
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
