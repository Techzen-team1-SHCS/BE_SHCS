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
            if (!Schema::hasColumn('users', 'wallet_balance')) {
                $table->decimal('wallet_balance', 15, 2)->notNull()->default(0.00);
            }
            if (!Schema::hasColumn('users', 'is_blocked')) {
                $table->tinyInteger('is_blocked')->notNull()->default(0);
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $columns = [];
            if (Schema::hasColumn('users', 'role')) $columns[] = 'role';
            if (Schema::hasColumn('users', 'gender')) $columns[] = 'gender';
            if (Schema::hasColumn('users', 'birth')) $columns[] = 'birth';
            if (Schema::hasColumn('users', 'address')) $columns[] = 'address';
            if (Schema::hasColumn('users', 'image')) $columns[] = 'image';
            if (Schema::hasColumn('users', 'wallet_balance')) $columns[] = 'wallet_balance';
            if (Schema::hasColumn('users', 'is_blocked')) $columns[] = 'is_blocked';
            
            if (!empty($columns)) {
                $table->dropColumn($columns);
            }
        });
    }
};
