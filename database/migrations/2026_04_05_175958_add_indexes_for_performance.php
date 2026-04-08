<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Helper to check if index exists using raw SQL to avoid Doctrine dependency
     */
    private function indexExists($table, $index)
    {
        $conn = Schema::getConnection();
        $db = $conn->getDatabaseName();
        $results = $conn->select("
            SELECT index_name 
            FROM information_schema.statistics 
            WHERE table_schema = '$db' 
              AND table_name = '$table' 
              AND index_name = '$index'
        ");
        return count($results) > 0;
    }

    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // 1. hotels table
        Schema::table('hotels', function (Blueprint $table) {
            if (!$this->indexExists('hotels', 'hotels_user_id_index')) {
                $table->index('user_id');
            }
        });

        // 2. rooms table
        Schema::table('rooms', function (Blueprint $table) {
            if (!$this->indexExists('rooms', 'rooms_hotel_id_index')) {
                $table->index('hotel_id');
            }
        });

        // 3. room_numbers table
        Schema::table('room_numbers', function (Blueprint $table) {
            if (!$this->indexExists('room_numbers', 'room_numbers_room_id_index')) {
                $table->index('room_id');
            }
            if (!$this->indexExists('room_numbers', 'room_numbers_hk_status_index')) {
                $table->index('hk_status');
            }
        });

        // 4. housekeeping_tasks table
        Schema::table('housekeeping_tasks', function (Blueprint $table) {
            if (!$this->indexExists('housekeeping_tasks', 'housekeeping_tasks_room_number_id_index')) {
                $table->index('room_number_id');
            }
            if (!$this->indexExists('housekeeping_tasks', 'housekeeping_tasks_assigned_to_index')) {
                $table->index('assigned_to');
            }
            if (!$this->indexExists('housekeeping_tasks', 'housekeeping_tasks_task_status_index')) {
                $table->index('task_status');
            }
            if (!$this->indexExists('housekeeping_tasks', 'housekeeping_tasks_scheduled_date_index')) {
                $table->index('scheduled_date');
            }
        });

        // 5. housekeeping_logs table
        Schema::table('housekeeping_logs', function (Blueprint $table) {
            if (!$this->indexExists('housekeeping_logs', 'housekeeping_logs_room_number_id_index')) {
                $table->index('room_number_id');
            }
            if (!$this->indexExists('housekeeping_logs', 'housekeeping_logs_changed_by_index')) {
                $table->index('changed_by');
            }
        });

        // 6. maintenance_issues table
        Schema::table('maintenance_issues', function (Blueprint $table) {
            if (!$this->indexExists('maintenance_issues', 'maintenance_issues_room_number_id_index')) {
                $table->index('room_number_id');
            }
            if (!$this->indexExists('maintenance_issues', 'maintenance_issues_issue_status_index')) {
                $table->index('issue_status');
            }
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('maintenance_issues', function (Blueprint $table) {
            if ($this->indexExists('maintenance_issues', 'maintenance_issues_room_number_id_index')) $table->dropIndex(['room_number_id']);
            if ($this->indexExists('maintenance_issues', 'maintenance_issues_issue_status_index')) $table->dropIndex(['issue_status']);
        });

        Schema::table('housekeeping_logs', function (Blueprint $table) {
            if ($this->indexExists('housekeeping_logs', 'housekeeping_logs_room_number_id_index')) $table->dropIndex(['room_number_id']);
            if ($this->indexExists('housekeeping_logs', 'housekeeping_logs_changed_by_index')) $table->dropIndex(['changed_by']);
        });

        Schema::table('housekeeping_tasks', function (Blueprint $table) {
            if ($this->indexExists('housekeeping_tasks', 'housekeeping_tasks_room_number_id_index')) $table->dropIndex(['room_number_id']);
            if ($this->indexExists('housekeeping_tasks', 'housekeeping_tasks_assigned_to_index')) $table->dropIndex(['assigned_to']);
            if ($this->indexExists('housekeeping_tasks', 'housekeeping_tasks_task_status_index')) $table->dropIndex(['task_status']);
            if ($this->indexExists('housekeeping_tasks', 'housekeeping_tasks_scheduled_date_index')) $table->dropIndex(['scheduled_date']);
        });

        Schema::table('room_numbers', function (Blueprint $table) {
            if ($this->indexExists('room_numbers', 'room_numbers_room_id_index')) $table->dropIndex(['room_id']);
            if ($this->indexExists('room_numbers', 'room_numbers_hk_status_index')) $table->dropIndex(['hk_status']);
        });

        Schema::table('rooms', function (Blueprint $table) {
            if ($this->indexExists('rooms', 'rooms_hotel_id_index')) $table->dropIndex(['hotel_id']);
        });

        Schema::table('hotels', function (Blueprint $table) {
            if ($this->indexExists('hotels', 'hotels_user_id_index')) $table->dropIndex(['user_id']);
        });
    }
};
