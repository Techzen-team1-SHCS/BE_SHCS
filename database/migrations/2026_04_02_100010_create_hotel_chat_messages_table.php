<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('hotel_chat_messages', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('thread_id');
            $table->string('sender_type'); // 'user'|'hm'
            $table->unsignedBigInteger('sender_id');
            $table->text('content');
            $table->string('type')->default('text');
            $table->timestamps();

            $table->foreign('thread_id')->references('id')->on('hotel_chat_threads')->onDelete('cascade');
            $table->index('thread_id');
            $table->index('sender_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('hotel_chat_messages');
    }
};
