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
        Schema::create('comments', function (Blueprint $table) {
            $table->id('maComment'); // maComment bigint unsigned auto_increment
            $table->unsignedBigInteger('userId')->index(); // userId bigint unsigned index
            $table->unsignedBigInteger('parent_id')->nullable()->index(); // parent_id bigint unsigned nullable index
            $table->text('comment'); // comment text
            $table->string('userName'); // userName varchar(255)
            $table->string('userAvatar'); // userAvatar varchar(255)
            $table->unsignedBigInteger('maHotel')->nullable(); // maHotel bigint unsigned nullable
            $table->unsignedBigInteger('maBlog')->nullable(); // maBlog bigint unsigned nullable
            $table->integer('level')->default(0); // level int default 0
            $table->timestamp('time')->useCurrent(); // time timestamp default CURRENT_TIMESTAMP
            $table->timestamps(); // created_at và updated_at nullable
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('comments');
    }
};
