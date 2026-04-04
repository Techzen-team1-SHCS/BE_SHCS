<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    public function up(): void
    {
        $indexes = [
            ['bookings', 'idx_bookings_status_created_at', ['status', 'created_at']],
            ['bookings', 'idx_bookings_check_in_check_out', ['check_in', 'check_out']],
            ['bookings', 'idx_bookings_payment_status', ['payment_status']],
            ['rooms', 'idx_rooms_hotel_status_guest', ['hotel_id', 'availability_status', 'max_guest']],
            ['hotels', 'idx_hotels_province', ['province']],
            ['payments', 'idx_payments_status_created_at', ['status', 'created_at']],
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
            ['bookings', 'idx_bookings_status_created_at'],
            ['bookings', 'idx_bookings_check_in_check_out'],
            ['bookings', 'idx_bookings_payment_status'],
            ['rooms', 'idx_rooms_hotel_status_guest'],
            ['hotels', 'idx_hotels_province'],
            ['payments', 'idx_payments_status_created_at'],
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
