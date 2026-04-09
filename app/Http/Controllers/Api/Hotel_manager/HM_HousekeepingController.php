<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Http\Controllers\Controller;
use App\Models\HousekeepingLog;
use App\Models\HousekeepingTask;
use App\Models\MaintenanceIssue;
use App\Models\RoomNumber;
use App\Models\Staff;
use Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;

class HM_HousekeepingController extends Controller
{
    // ---------------------------------------------------------------------------
    // 1. DASHBOARD — Stats tổng quan
    // GET /api/auth/hotel-manager/housekeeping/dashboard
    // ---------------------------------------------------------------------------
    public function dashboard(Request $request)
    {
        $user = Auth::user();
        $cacheKey = 'hk_dashboard_user_' . $user->id;

        $data = Cache::remember($cacheKey, 300, function () use ($user) {
            $today = now()->toDateString();
            
            // Base query for all room numbers belonging to this user's hotels
            $baseQuery = RoomNumber::join('rooms', 'room_numbers.room_id', '=', 'rooms.id')
                ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
                ->withoutGlobalScopes()
                ->where('hotels.user_id', $user->id);

            // Thống kê hk_status
            $hkStats = (clone $baseQuery)
                ->selectRaw('hk_status, COUNT(*) as count')
                ->groupBy('hk_status')
                ->pluck('count', 'hk_status');

            // Thống kê tasks hôm nay
            $taskStats = HousekeepingTask::join('room_numbers', 'housekeeping_tasks.room_number_id', '=', 'room_numbers.id')
                ->join('rooms', 'room_numbers.room_id', '=', 'rooms.id')
                ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
                ->withoutGlobalScopes()
                ->where('hotels.user_id', $user->id)
                ->where('scheduled_date', $today)
                ->selectRaw('task_status, COUNT(*) as count')
                ->groupBy('task_status')
                ->pluck('count', 'task_status');

            // Thống kê sự cố bảo trì
            $issueStats = MaintenanceIssue::join('room_numbers', 'maintenance_issues.room_number_id', '=', 'room_numbers.id')
                ->join('rooms', 'room_numbers.room_id', '=', 'rooms.id')
                ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
                ->withoutGlobalScopes()
                ->where('hotels.user_id', $user->id)
                ->selectRaw('issue_status, COUNT(*) as count')
                ->groupBy('issue_status')
                ->pluck('count', 'issue_status');

            return [
                'hk_status'   => $hkStats,
                'tasks_today' => $taskStats,
                'issues'      => $issueStats,
                'total_rooms' => (clone $baseQuery)->count(),
            ];
        });

        return response()->json([
            'status'  => true,
            'data'    => $data,
        ]);
    }

    private function clearDashboardCache()
    {
        Cache::forget('hk_dashboard_user_' . Auth::id());
    }

    // ---------------------------------------------------------------------------
    // 2. TASKS — Danh sách nhiệm vụ
    // GET /api/auth/hotel-manager/housekeeping/tasks
    // Query params: status, date, staff_id, page, per_page
    // ---------------------------------------------------------------------------
    public function tasks(Request $request)
    {
        $user = Auth::user();

        // Gộp trực tiếp vào query chính
        $query = HousekeepingTask::whereHas('roomNumber.room.hotel', function ($q) use ($user) {
                $q->withoutGlobalScopes()->where('user_id', $user->id);
            })
            ->with([
                'roomNumber:id,room_number,hk_status,fo_status,do_not_disturb,room_id',
                'roomNumber.room:id,room_type,hotel_id',
                'assignedStaff:id,name,avatar',
            ]);

        // Filters
        if ($request->filled('status')) {
            $query->where('task_status', $request->status);
        }
        if ($request->filled('date')) {
            $query->where('scheduled_date', $request->date);
        }
        if ($request->filled('staff_id')) {
            $query->where('assigned_to', $request->staff_id);
        }
        if ($request->filled('priority')) {
            $query->where('priority', $request->priority);
        }

        $perPage = $request->get('per_page', 15);
        $tasks   = $query->latest()->paginate($perPage);

        return response()->json([
            'status' => true,
            'data'   => $tasks,
        ]);
}

    // ---------------------------------------------------------------------------
    // 3. CREATE TASK
    // POST /api/auth/hotel-manager/housekeeping/tasks
    // Body: room_number_id, assigned_to?, task_type, priority, scheduled_date, notes?
    // ---------------------------------------------------------------------------
    public function storeTask(Request $request)
    {
        $validated = $request->validate([
            'room_number_id' => 'required|exists:room_numbers,id',
            'assigned_to'    => 'nullable|exists:staff,id',
            'task_type'      => 'required|in:stay-over,checkout,turn-down,deep-clean',
            'task_status'    => 'nullable|in:pending,in-progress,completed,skipped',
            'priority'       => 'nullable|in:low,normal,high,urgent',
            'scheduled_date' => 'required|date',
            'notes'          => 'nullable|string|max:500',
        ]);

        $task = HousekeepingTask::create($validated);
        $task->load(['roomNumber.room', 'assignedStaff:id,name,avatar']);
        $this->clearDashboardCache();

        return response()->json([
            'status'  => true,
            'message' => 'Tạo nhiệm vụ thành công',
            'data'    => $task,
        ], 201);
    }

    // ---------------------------------------------------------------------------
    // 4. UPDATE TASK (assign, change status, notes…)
    // PUT /api/auth/hotel-manager/housekeeping/tasks/{id}
    // ---------------------------------------------------------------------------
    public function updateTask(Request $request, $id)
    {
        $task = HousekeepingTask::findOrFail($id);

        $validated = $request->validate([
            'assigned_to'    => 'nullable|exists:staff,id',
            'task_type'      => 'nullable|in:stay-over,checkout,turn-down,deep-clean',
            'task_status'    => 'nullable|in:pending,in-progress,completed,skipped',
            'priority'       => 'nullable|in:low,normal,high,urgent',
            'scheduled_date' => 'nullable|date',
            'notes'          => 'nullable|string|max:500',
        ]);

        // Nếu chuyển sang completed, ghi nhận thời gian
        if (isset($validated['task_status']) && $validated['task_status'] === 'completed') {
            $validated['completed_at'] = now();

            // Tự động cập nhật hk_status của phòng thành clean
            $task->roomNumber->update(['hk_status' => 'clean']);

            // Ghi log
            HousekeepingLog::create([
                'room_number_id' => $task->room_number_id,
                'changed_by'     => $task->assigned_to,
                'old_status'     => $task->roomNumber->hk_status,
                'new_status'     => 'clean',
            ]);
        }

        $task->update($validated);
        $task->load(['roomNumber.room', 'assignedStaff:id,name,avatar']);
        $this->clearDashboardCache();

        return response()->json([
            'status'  => true,
            'message' => 'Cập nhật nhiệm vụ thành công',
            'data'    => $task,
        ]);
    }

    // ---------------------------------------------------------------------------
    // 5. DELETE TASK
    // DELETE /api/auth/hotel-manager/housekeeping/tasks/{id}
    // ---------------------------------------------------------------------------
    public function destroyTask($id)
    {
        $task = HousekeepingTask::findOrFail($id);
        $task->delete();
        $this->clearDashboardCache();

        return response()->json([
            'status'  => true,
            'message' => 'Xóa nhiệm vụ thành công',
        ]);
    }

    // ---------------------------------------------------------------------------
    // 6. ROOM STATUS LIST — Danh sách phòng với trạng thái HK, grouped by hotel
    // GET /api/auth/hotel-manager/housekeeping/rooms
    // ---------------------------------------------------------------------------
    public function roomStatuses(Request $request)
    {
        $user = Auth::user();

        // Use Join to fetch rooms belonging to the manager's hotels
        $query = RoomNumber::join('rooms', 'room_numbers.room_id', '=', 'rooms.id')
            ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->withoutGlobalScopes()
            ->where('hotels.user_id', $user->id)
            ->with([
                'room:id,room_type,hotel_id',
                'room.hotel:id,name,province',
            ]);

        if ($request->filled('hk_status')) {
            $query->where('room_numbers.hk_status', $request->hk_status);
        }

        if ($request->filled('hotel_id')) {
            $query->where('rooms.hotel_id', $request->hotel_id);
        }

        // Get total counts and info grouped by hotel using SQL for performance
        $rooms = $query->get(['room_numbers.id', 'room_number', 'hk_status', 'fo_status', 'do_not_disturb', 'room_numbers.room_id']);

        $grouped = $rooms->groupBy('room.hotel_id')
            ->map(function ($hotelRooms) {
                $hotel = $hotelRooms->first()->room->hotel;
                return [
                    'hotel_id'   => $hotel?->id,
                    'hotel_name' => $hotel?->name ?? 'Không xác định',
                    'hotel_address' => $hotel?->province ?? '',
                    'total'      => $hotelRooms->count(),
                    'stats' => [
                        'dirty'        => $hotelRooms->where('hk_status', 'dirty')->count(),
                        'clean'        => $hotelRooms->where('hk_status', 'clean')->count(),
                        'cleaning'     => $hotelRooms->where('hk_status', 'cleaning')->count(),
                        'inspected'    => $hotelRooms->where('hk_status', 'inspected')->count(),
                        'out-of-order' => $hotelRooms->where('hk_status', 'out-of-order')->count(),
                    ],
                    'rooms' => $hotelRooms->values(),
                ];
            })->values();

        return response()->json([
            'status' => true,
            'data'   => $grouped,
        ]);
    }

    // ---------------------------------------------------------------------------
    // 7. UPDATE ROOM HK STATUS
    // PUT /api/auth/hotel-manager/housekeeping/rooms/{id}/status
    // Body: hk_status, fo_status?, do_not_disturb?, changed_by?
    // ---------------------------------------------------------------------------
    public function updateRoomStatus(Request $request, $id)
    {
        $room = RoomNumber::findOrFail($id);

        $validated = $request->validate([
            'hk_status'      => 'nullable|in:dirty,clean,cleaning,inspected,out-of-order',
            'fo_status'      => 'nullable|in:vacant,occupied',
            'do_not_disturb' => 'nullable|boolean',
            'changed_by'     => 'nullable|exists:staff,id',
        ]);

        $oldStatus = $room->hk_status;

        $room->update($validated);

        // Ghi log khi hk_status thay đổi
        if (isset($validated['hk_status']) && $validated['hk_status'] !== $oldStatus) {
            HousekeepingLog::create([
                'room_number_id' => $room->id,
                'changed_by'     => $validated['changed_by'] ?? null,
                'old_status'     => $oldStatus,
                'new_status'     => $validated['hk_status'],
            ]);
        }

        $this->clearDashboardCache();

        return response()->json([
            'status'  => true,
            'message' => 'Cập nhật trạng thái phòng thành công',
            'data'    => $room->fresh(),
        ]);
    }

    // ---------------------------------------------------------------------------
    // 8. LOGS — Lịch sử thay đổi trạng thái
    // GET /api/auth/hotel-manager/housekeeping/logs
    // Query: room_number_id?, per_page?
    // ---------------------------------------------------------------------------
    public function logs(Request $request)
    {
        $user = Auth::user();

        $roomNumberIds = RoomNumber::whereHas('room.hotel', function ($q) use ($user) {
            $q->withoutGlobalScopes()->where('user_id', $user->id);
        })->pluck('id');

        $query = HousekeepingLog::whereIn('room_number_id', $roomNumberIds)
            ->with([
                'roomNumber:id,room_number',
                'changedBy:id,name',
            ])
            ->orderByDesc('changed_at');

        if ($request->filled('room_number_id')) {
            $query->where('room_number_id', $request->room_number_id);
        }

        $logs = $query->paginate($request->get('per_page', 20));

        return response()->json([
            'status' => true,
            'data'   => $logs,
        ]);
    }

    // ---------------------------------------------------------------------------
    // 9. MAINTENANCE ISSUES — Danh sách sự cố
    // GET /api/auth/hotel-manager/housekeeping/issues
    // Query: status?, per_page?
    // ---------------------------------------------------------------------------
    public function issues(Request $request)
    {
        $user = Auth::user();

        $roomNumberIds = RoomNumber::whereHas('room.hotel', function ($q) use ($user) {
            $q->withoutGlobalScopes()->where('user_id', $user->id);
        })->pluck('id');

        $query = MaintenanceIssue::whereIn('room_number_id', $roomNumberIds)
            ->with([
                'roomNumber:id,room_number,room_id',
                'roomNumber.room:id,room_type',
                'reportedBy:id,name,avatar',
            ]);

        if ($request->filled('status')) {
            $query->where('issue_status', $request->status);
        }

        $issues = $query->latest()->paginate($request->get('per_page', 15));

        return response()->json([
            'status' => true,
            'data'   => $issues,
        ]);
    }

    // ---------------------------------------------------------------------------
    // 10. CREATE MAINTENANCE ISSUE
    // POST /api/auth/hotel-manager/housekeeping/issues
    // Body: room_number_id, reported_by?, description, image_url?
    // ---------------------------------------------------------------------------
    public function storeIssue(Request $request)
    {
        $validated = $request->validate([
            'room_number_id' => 'required|exists:room_numbers,id',
            'reported_by'    => 'nullable|exists:staff,id',
            'description'    => 'required|string|max:1000',
            'image_url'      => 'nullable|url',
        ]);

        // Tự động set phòng thành out-of-order khi báo sự cố
        $room = RoomNumber::find($validated['room_number_id']);
        $oldStatus = $room->hk_status;
        $room->update(['hk_status' => 'out-of-order']);

        // Ghi log
        HousekeepingLog::create([
            'room_number_id' => $room->id,
            'changed_by'     => $validated['reported_by'] ?? null,
            'old_status'     => $oldStatus,
            'new_status'     => 'out-of-order',
        ]);

        $issue = MaintenanceIssue::create($validated);
        $issue->load(['roomNumber.room', 'reportedBy:id,name,avatar']);
        $this->clearDashboardCache();

        return response()->json([
            'status'  => true,
            'message' => 'Báo cáo sự cố thành công',
            'data'    => $issue,
        ], 201);
    }

    // ---------------------------------------------------------------------------
    // 11. UPDATE MAINTENANCE ISSUE STATUS
    // PUT /api/auth/hotel-manager/housekeeping/issues/{id}
    // Body: issue_status, description?, image_url?
    // ---------------------------------------------------------------------------
    public function updateIssue(Request $request, $id)
    {
        $issue = MaintenanceIssue::findOrFail($id);

        $validated = $request->validate([
            'issue_status' => 'nullable|in:open,fixing,resolved',
            'description'  => 'nullable|string|max:1000',
            'image_url'    => 'nullable|url',
        ]);

        // Khi resolved, phòng quay về dirty (chờ dọn)
        if (isset($validated['issue_status']) && $validated['issue_status'] === 'resolved') {
            $issue->roomNumber->update(['hk_status' => 'dirty']);
            HousekeepingLog::create([
                'room_number_id' => $issue->room_number_id,
                'changed_by'     => null,
                'old_status'     => 'out-of-order',
                'new_status'     => 'dirty',
            ]);
        }

        $issue->update($validated);
        $this->clearDashboardCache();

        return response()->json([
            'status'  => true,
            'message' => 'Cập nhật sự cố thành công',
            'data'    => $issue->fresh(['roomNumber.room', 'reportedBy:id,name,avatar']),
        ]);
    }
}
