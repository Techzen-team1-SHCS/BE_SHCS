<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('housekeeping_tasks', function (Blueprint $table) {
            $table->id();

            $table->foreignId('room_number_id')
                  ->constrained('room_numbers')
                  ->cascadeOnDelete();

            $table->foreignId('assigned_to')
                  ->nullable()
                  ->constrained('staff')
                  ->nullOnDelete();

            $table->enum('task_type', [
                'stay-over',   // Dọn hằng ngày khi khách đang ở
                'checkout',    // Dọn sâu sau khi khách trả phòng
                'turn-down',   // Dịch vụ dọn giường buổi tối
                'deep-clean',  // Vệ sinh sâu định kỳ
            ])->default('stay-over');

            $table->enum('task_status', [
                'pending',
                'in-progress',
                'completed',
                'skipped',
            ])->default('pending');

            $table->enum('priority', [
                'low',
                'normal',
                'high',
                'urgent',
            ])->default('normal');

            $table->date('scheduled_date');
            $table->timestamp('completed_at')->nullable();
            $table->text('notes')->nullable();

            $table->timestamps();

            $table->index(['task_status', 'scheduled_date']);
            $table->index('assigned_to');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('housekeeping_tasks');
    }
};
