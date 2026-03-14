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
        Schema::table('users', function (Blueprint $table) {
            if (!Schema::hasColumn('users', 'role')) {
                $table->tinyInteger('role')->after('email')->default(0)->comment('0 = user,1 = admin,2 = bussiness');
            }
            if (!Schema::hasColumn('users', 'gender')) {
                $table->string('gender')->nullable()->after('role');
            }
            if (!Schema::hasColumn('users', 'birth')) {
                $table->date('birth')->nullable()->after('gender');
            }
            if (!Schema::hasColumn('users', 'address')) {
                $table->string('address', 50)->nullable()->after('birth');
            }
            if (!Schema::hasColumn('users', 'image')) {
                $table->string('image')->nullable()->after('phone');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['role', 'gender', 'birth', 'address', 'image']);
        });
    }
};
