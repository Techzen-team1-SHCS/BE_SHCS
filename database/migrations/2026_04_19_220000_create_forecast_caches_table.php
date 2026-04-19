<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('forecast_caches', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('hotel_id')->nullable()->index();
            $table->string('hotel_ref')->index();
            $table->unsignedInteger('hotel_capacity')->default(30);
            $table->unsignedInteger('horizon_days')->default(30);
            $table->string('mode', 20)->default('daily_delta');
            $table->json('payload_sent');
            $table->json('ai_result');
            $table->timestamps();

            $table->index(['hotel_ref', 'horizon_days', 'mode']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('forecast_caches');
    }
};
