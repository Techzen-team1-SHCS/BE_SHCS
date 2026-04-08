<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('maintenance_issues', function (Blueprint $table) {
            $table->id();

            $table->foreignId('room_number_id')
                  ->constrained('room_numbers')
                  ->cascadeOnDelete();

            // Nhân viên buồng phòng báo cáo sự cố
            $table->foreignId('reported_by')
                  ->nullable()
                  ->constrained('staff')
                  ->nullOnDelete();

            $table->text('description');

            $table->enum('issue_status', [
                'open',     // Mới báo cáo
                'fixing',   // Đang sửa
                'resolved', // Đã sửa xong
            ])->default('open');

            // Ảnh chụp sự cố (lưu URL từ ImageKit)
            $table->string('image_url')->nullable();

            $table->timestamps();

            $table->index('issue_status');
            $table->index('room_number_id');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('maintenance_issues');
    }
};
