<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('housekeeping_logs', function (Blueprint $table) {
            $table->id();

            $table->foreignId('room_number_id')
                  ->constrained('room_numbers')
                  ->cascadeOnDelete();

            // Nhân viên đổi trạng thái (nullable vì có thể do hệ thống tự đổi)
            $table->foreignId('changed_by')
                  ->nullable()
                  ->constrained('staff')
                  ->nullOnDelete();

            $table->string('old_status', 50);
            $table->string('new_status', 50);

            // Thời gian chính xác — dùng timestamp riêng thay vì timestamps()
            $table->timestamp('changed_at')->useCurrent();

            $table->index('room_number_id');
            $table->index('changed_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('housekeeping_logs');
    }
};
