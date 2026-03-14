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

        // Add FULLTEXT index if not exists
        try {
            DB::statement('ALTER TABLE hotels ADD FULLTEXT KEY idx_name_description (name, description)');
        } catch (\Exception $e) {
            // Index might already exist
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('hotels', function (Blueprint $table) {
            $columns = [];
            if (Schema::hasColumn('hotels', 'text')) $columns[] = 'text';
            if (Schema::hasColumn('hotels', 'amenities')) $columns[] = 'amenities';
            if (Schema::hasColumn('hotels', 'status')) $columns[] = 'status';
            
            if (!empty($columns)) {
                $table->dropColumn($columns);
            }
            
            try {
                $table->dropIndex('idx_name_description');
            } catch (\Exception $e) {
                // Index might not exist
            }
        });
    }
};
