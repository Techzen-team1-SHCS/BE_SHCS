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
        Schema::dropIfExists('support_tickets');
        
        Schema::create('support_tickets', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id');
            $table->string('subject');
            $table->text('message');
            $table->enum('status', ['open', 'closed'])->default('open');
            $table->timestamps();
            
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('support_tickets');
        Schema::create('support_tickets', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email');
            $table->string('subject');
            $table->enum('priority', ['low', 'medium', 'high', 'urgent'])->default('medium');
            $table->text('message');
            $table->enum('status', ['pending', 'in_progress', 'resolved'])->default('pending');
            $table->string('ticket_number')->unique();
            $table->timestamps();
        });
    }
};
