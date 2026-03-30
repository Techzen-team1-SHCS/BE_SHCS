<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Http\Controllers\Controller;
use App\Models\Room;
use App\Models\RoomNumber;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class HM_RoomNumberController extends Controller
{
    /**
     * Danh sách room numbers theo room_id
     */
    public function index_room_numbers($roomId)
    {
        $room = Room::with('hotel')->findOrFail($roomId);
        $this->authorize('view', $room);
        $roomNumbers = $room->roomNumbers()
            ->orderBy('id', 'asc')
            ->get();

        return response()->json([
            'status' => true,
            'data' => $roomNumbers,
        ]);
    }

    /**
     * Bulk create room_numbers cho 1 room
     * - quantity = 10 => room_number: 101..110
     * - quantity = 20 => room_number: 101..120
     * - status mặc định: available
     */
    public function store_room_numbers(Request $request, $roomId)
    {
        $request->validate([
            'quantity' => ['required', 'integer', 'min:1', 'max:500'],
            'status' => ['nullable', 'in:available,booked,maintenance'],
        ]);

        $room = Room::with('hotel')->findOrFail($roomId);

        // Authorize theo RoomNumberPolicy (không dựa vào HotelPolicy)
        $roomNumberCandidate = new RoomNumber();
        $roomNumberCandidate->setRelation('room', $room);
        $this->authorize('create', $roomNumberCandidate);

        $quantity = (int) $request->quantity;
        $prefixMap = [
            'Normal' => 100,
            'Standard' => 200,
            'Deluxe' => 300,
        ];

        // Không cần truyền prefix từ client: map theo room_type
        $normalizedRoomTypeKey = ucfirst(mb_strtolower(trim((string) $room->room_type)));
        if (!array_key_exists($normalizedRoomTypeKey, $prefixMap)) {
            return response()->json([
                'status' => false,
                'message' => 'room_type không hợp lệ để sinh room_number: ' . $room->room_type,
            ], 422);
        }
        $prefix = (int) $prefixMap[$normalizedRoomTypeKey];

        $status = $request->status ?? 'available';

        DB::beginTransaction();
        try {
            $codes = [];
            for ($i = 0; $i < $quantity; $i++) {
                // Ví dụ: prefix=200, quantity=3 => 200, 201, 202
                $codes[] = (string) ($prefix + $i);
            }

            $existingCodes = RoomNumber::where('room_id', $roomId)
                ->whereIn('room_number', $codes)
                ->pluck('room_number')
                ->values()
                ->all();

            $toCreateCodes = array_values(array_diff($codes, $existingCodes));

            if (count($toCreateCodes) === 0) {
                DB::rollBack();
                return response()->json([
                    'status' => true,
                    'message' => 'Không có room_number mới để tạo (tất cả mã đã tồn tại)',
                    'data' => [],
                    'skipped' => $existingCodes,
                ], 200);
            }

            $now = now();
            $rows = [];
            foreach ($toCreateCodes as $code) {
                $rows[] = [
                    'room_id' => $roomId,
                    'room_number' => $code,
                    'status' => $status,
                    'created_at' => $now,
                    'updated_at' => $now,
                ];
            }

            RoomNumber::insert($rows);

            $created = RoomNumber::where('room_id', $roomId)
                ->whereIn('room_number', $toCreateCodes)
                ->orderBy('id', 'asc')
                ->get();

            DB::commit();

            return response()->json([
                'status' => true,
                'message' => 'Tạo room_number thành công',
                'data' => $created,
                'skipped' => $existingCodes,
            ], 201);
        } catch (\Throwable $e) {
            DB::rollBack();

            return response()->json([
                'status' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    /**
     * Update 1 room_number (thường dùng để đổi status)
     */
    public function update_room_number($id, Request $request)
    {
        $roomNumber = RoomNumber::with('room.hotel')->findOrFail($id);
        $this->authorize('update', $roomNumber);

        $validated = $request->validate([
            'status' => ['nullable', 'in:available,booked,maintenance'],
            'room_number' => ['nullable', 'string', 'max:50'],
        ]);

        if (array_key_exists('room_number', $validated)) {
            $roomId = $roomNumber->room_id;
            $roomNumberValue = $validated['room_number'];

            $exists = RoomNumber::where('room_id', $roomId)
                ->where('room_number', $roomNumberValue)
                ->where('id', '!=', $roomNumber->id)
                ->exists();

            if ($exists) {
                return response()->json([
                    'status' => false,
                    'message' => 'room_number này đã tồn tại trong room',
                ], 409);
            }
        }

        $roomNumber->update($validated);

        return response()->json([
            'status' => true,
            'message' => 'Cập nhật room_number thành công',
            'data' => $roomNumber,
        ]);
    }

    public function delete_room_number($id)
    {
        $roomNumber = RoomNumber::with('room.hotel')->findOrFail($id);
        $this->authorize('delete', $roomNumber);

        $roomNumber->delete();

        return response()->json([
            'status' => true,
            'message' => 'Xóa room_number thành công',
        ]);
    }
}
