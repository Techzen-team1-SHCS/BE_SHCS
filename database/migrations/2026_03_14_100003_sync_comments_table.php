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
        Schema::table('comments', function (Blueprint $table) {
            // Chỉ đổi tên nếu cột cũ maComment tồn tại và cột mới id chưa tồn tại
            if (Schema::hasColumn('comments', 'maComment') && !Schema::hasColumn('comments', 'id')) {
                $table->renameColumn('maComment', 'id');
            }

            // Làm cho userAvatar có thể null
            $table->string('userAvatar')->nullable()->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('comments', function (Blueprint $table) {
            if (Schema::hasColumn('comments', 'id') && !Schema::hasColumn('comments', 'maComment')) {
                $table->renameColumn('id', 'maComment');
            }
            
            $table->string('userAvatar')->nullable(false)->change();
        });
    }
};
