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
        Schema::table('wishlists', function (Blueprint $table) {
            if (!Schema::hasColumn('wishlists', 'hotel_id')) {
                $table->foreignId('hotel_id')->nullable()->after('user_id')->constrained()->onDelete('cascade');
            }
            
            // Nếu bạn muốn wishlist có thể áp dụng cho cả hotel hoặc room, chúng ta giữ cả 2.
            // Nhưng thông thường wishlist thường dành cho Hotel, nên ta cho room_id nullable nếu cần.
            if (Schema::hasColumn('wishlists', 'room_id')) {
                $table->unsignedBigInteger('room_id')->nullable()->change();
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('wishlists', function (Blueprint $table) {
            if (Schema::hasColumn('wishlists', 'hotel_id')) {
                $table->dropForeign(['hotel_id']);
                $table->dropColumn('hotel_id');
            }
            
            if (Schema::hasColumn('wishlists', 'room_id')) {
                $table->unsignedBigInteger('room_id')->nullable(false)->change();
            }
        });
    }
};
