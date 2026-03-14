<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('hotels', function (Blueprint $table) {
            if (!Schema::hasColumn('hotels', 'text')) {
                $table->text('text')->nullable()->after('price');
            }
            if (!Schema::hasColumn('hotels', 'amenities')) {
                $table->json('amenities')->nullable()->after('hotel_class');
            }
            if (!Schema::hasColumn('hotels', 'status')) {
                $table->enum('status', ['pending', 'approved', 'rejected'])->default('pending')->after('user_id');
            }
        });

        // Add FULLTEXT index
        DB::statement('ALTER TABLE hotels ADD FULLTEXT KEY idx_name_description (name, description)');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('hotels', function (Blueprint $table) {
            $table->dropColumn(['text', 'amenities', 'status']);
            $table->dropIndex('idx_name_description');
        });
    }
};
