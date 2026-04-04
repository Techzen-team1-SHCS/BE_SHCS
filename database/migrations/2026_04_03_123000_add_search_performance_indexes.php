<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        $indexes = [
            ['rooms', 'idx_rooms_hotel_available_window', ['hotel_id', 'quantity', 'available_from', 'available_to']],
            ['images', 'idx_images_type_reference', ['type', 'reference_id']],
            ['hotel_styles', 'idx_hotel_styles_hotel_style', ['hotel_id', 'style_id']],
            ['hotel_styles', 'idx_hotel_styles_style_hotel', ['style_id', 'hotel_id']],
            ['bookings', 'idx_bookings_room_status_window', ['room_id', 'status', 'check_in', 'check_out']],
        ];

        foreach ($indexes as [$table, $indexName, $columns]) {
            if ($this->indexExists($table, $indexName)) {
                continue;
            }

            $columnList = implode(',', array_map(fn ($c) => "`{$c}`", $columns));
            DB::statement("CREATE INDEX `{$indexName}` ON `{$table}` ({$columnList})");
        }
    }

    public function down(): void
    {
        $drops = [
            ['rooms', 'idx_rooms_hotel_available_window'],
            ['images', 'idx_images_type_reference'],
            ['hotel_styles', 'idx_hotel_styles_hotel_style'],
            ['hotel_styles', 'idx_hotel_styles_style_hotel'],
            ['bookings', 'idx_bookings_room_status_window'],
        ];

        foreach ($drops as [$table, $indexName]) {
            if (!$this->indexExists($table, $indexName)) {
                continue;
            }

            DB::statement("DROP INDEX `{$indexName}` ON `{$table}`");
        }
    }

    private function indexExists(string $table, string $indexName): bool
    {
        $dbName = DB::getDatabaseName();
        $result = DB::selectOne(
            'SELECT COUNT(1) AS total FROM information_schema.statistics WHERE table_schema = ? AND table_name = ? AND index_name = ?',
            [$dbName, $table, $indexName]
        );

        return ((int) ($result->total ?? 0)) > 0;
    }
};
