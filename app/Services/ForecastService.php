<?php

namespace App\Services;

use App\Models\ForecastCache;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class ForecastService
{
    public const DEFAULT_HOTEL_CAPACITY = 30;
    public const DEFAULT_HORIZON_DAYS = 30;

    public function aiForecastUrl(): string
    {
        return env('AI_FORECAST_URL', 'https://spyglass-splendid-unrivaled.ngrok-free.dev/forecast');
    }

    public function resolveHotel(string $hotelIdInput): array
    {
        $hotelName = null;
        $hotelId = null;

        if (is_numeric($hotelIdInput)) {
            $hotelId = (int) $hotelIdInput;
            $hotelName = DB::table('hotels')->where('id', $hotelId)->value('name');
        } else {
            $hotelName = $hotelIdInput;
            $hotelId = DB::table('hotels')->where('name', $hotelName)->value('id');
        }

        return [
            'hotel_id' => $hotelId,
            'hotel_name' => $hotelName,
            'hotel_ref' => (string) ($hotelId ?? $hotelName ?? $hotelIdInput),
        ];
    }

    public function getLatestCachedResult(string $hotelRef, int $horizonDays, string $mode = 'daily_delta'): ?array
    {
        $record = ForecastCache::query()
            ->where('hotel_ref', $hotelRef)
            ->where('horizon_days', $horizonDays)
            ->where('mode', $mode)
            ->latest('id')
            ->first();

        if (!$record) {
            return null;
        }

        return [
            'message' => 'Lấy forecast từ DB cache thành công.',
            'mode' => $mode,
            'from_db_cache' => true,
            'cached_at' => optional($record->created_at)?->toDateTimeString(),
            'payload_sent' => $record->payload_sent,
            'ai_result' => $record->ai_result,
        ];
    }

    public function generateForecastDailyDelta(string $hotelIdInput, int $hotelCapacity, int $horizonDays): array
    {
        $resolved = $this->resolveHotel($hotelIdInput);
        $hotelId = $resolved['hotel_id'];
        $hotelName = $resolved['hotel_name'];
        $hotelRef = $resolved['hotel_ref'];

        if (!$hotelId && !$hotelName) {
            return [
                'ok' => false,
                'status' => 400,
                'body' => [
                    'message' => 'Không xác định được khách sạn từ hotel_id.',
                ],
            ];
        }

        $historicalData = $this->getYesterdayDelta($hotelId, $hotelName);

        $payload = [
            'hotel_id' => $hotelRef,
            'hotel_capacity' => $hotelCapacity,
            'horizon_days' => $horizonDays,
            'historical_data' => $historicalData,
        ];

        return $this->callAi($payload, true, $hotelId, $hotelRef, $hotelCapacity, $horizonDays);
    }

    public function generateForecastBootstrap(string $hotelIdInput, int $hotelCapacity, int $horizonDays, int $historyDays = 180): array
    {
        $resolved = $this->resolveHotel($hotelIdInput);
        $hotelId = $resolved['hotel_id'];
        $hotelName = $resolved['hotel_name'];
        $hotelRef = $resolved['hotel_ref'];

        if (!$hotelId && !$hotelName) {
            return [
                'ok' => false,
                'status' => 400,
                'body' => [
                    'message' => 'Không xác định được khách sạn từ hotel_id.',
                ],
            ];
        }

        $historicalData = $this->getHotelHistoricalData($hotelId, $hotelName, $historyDays);

        if (count($historicalData) < 2) {
            return [
                'ok' => false,
                'status' => 400,
                'body' => [
                    'message' => 'Không đủ dữ liệu lịch sử để bootstrap (cần tối thiểu 2 ngày).',
                ],
            ];
        }

        $payload = [
            'hotel_id' => $hotelRef,
            'hotel_capacity' => $hotelCapacity,
            'horizon_days' => $horizonDays,
            'historical_data' => $historicalData,
        ];

        return $this->callAi($payload, false, $hotelId, $hotelRef, $hotelCapacity, $horizonDays);
    }

    private function callAi(
        array $payload,
        bool $isDailyDelta,
        ?int $hotelId,
        string $hotelRef,
        int $hotelCapacity,
        int $horizonDays
    ): array {
        $mode = $isDailyDelta ? 'daily_delta' : 'bootstrap';

        try {
            $response = Http::timeout(60)
                ->acceptJson()
                ->post($this->aiForecastUrl(), $payload);

            if ($response->successful()) {
                $aiResult = $response->json();

                ForecastCache::create([
                    'hotel_id' => $hotelId,
                    'hotel_ref' => $hotelRef,
                    'hotel_capacity' => $hotelCapacity,
                    'horizon_days' => $horizonDays,
                    'mode' => $mode,
                    'payload_sent' => $payload,
                    'ai_result' => $aiResult,
                ]);

                return [
                    'ok' => true,
                    'status' => 200,
                    'body' => [
                        'message' => $isDailyDelta
                            ? 'Đã gửi dữ liệu ngày hôm qua sang AI và nhận forecast thành công.'
                            : 'Bootstrap dữ liệu lịch sử cho AI thành công.',
                        'mode' => $mode,
                        'from_db_cache' => false,
                        'payload_sent' => $payload,
                        'ai_result' => $aiResult,
                    ],
                ];
            }

            if ($response->status() === 400) {
                return [
                    'ok' => false,
                    'status' => 400,
                    'body' => [
                        'message' => 'AI đang thu thập dữ liệu…',
                        'mode' => $mode,
                        'ai_error' => $response->json() ?? $response->body(),
                    ],
                ];
            }

            return [
                'ok' => false,
                'status' => $response->status(),
                'body' => [
                    'message' => 'AI service trả về lỗi.',
                    'mode' => $mode,
                    'status_code' => $response->status(),
                    'ai_error' => $response->json() ?? $response->body(),
                ],
            ];
        } catch (\Throwable $e) {
            return [
                'ok' => false,
                'status' => 500,
                'body' => [
                    'message' => 'Không thể kết nối AI service.',
                    'mode' => $mode,
                    'error' => $e->getMessage(),
                ],
            ];
        }
    }

    private function getYesterdayDelta(?int $hotelId, ?string $hotelName): array
    {
        $yesterday = Carbon::yesterday()->toDateString();

        $query = DB::table('bookings')
            ->join('rooms', 'bookings.room_id', '=', 'rooms.id')
            ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->selectRaw('DATE(bookings.check_in) as ds, SUM(COALESCE(bookings.quantity, 1)) as rooms_booked')
            ->where('bookings.status', '!=', 'cancelled')
            ->whereDate('bookings.check_in', $yesterday)
            ->groupByRaw('DATE(bookings.check_in)');

        if ($hotelId) {
            $query->where('hotels.id', $hotelId);
        } elseif ($hotelName) {
            $query->where('hotels.name', $hotelName);
        }

        $row = $query->first();

        if ($row) {
            return [[
                'ds' => $row->ds,
                'rooms_booked' => max(0, (int) $row->rooms_booked),
            ]];
        }

        return [[
            'ds' => $yesterday,
            'rooms_booked' => 0,
        ]];
    }

    private function getHotelHistoricalData(?int $hotelId, ?string $hotelName, int $limit = 180): array
    {
        $query = DB::table('bookings')
            ->join('rooms', 'bookings.room_id', '=', 'rooms.id')
            ->join('hotels', 'rooms.hotel_id', '=', 'hotels.id')
            ->selectRaw('DATE(bookings.check_in) as ds, SUM(COALESCE(bookings.quantity, 1)) as rooms_booked')
            ->where('bookings.status', '!=', 'cancelled')
            ->groupByRaw('DATE(bookings.check_in)')
            ->orderBy('ds', 'asc')
            ->limit($limit);

        if ($hotelId) {
            $query->where('hotels.id', $hotelId);
        } elseif ($hotelName) {
            $query->where('hotels.name', $hotelName);
        }

        return $query
            ->get()
            ->map(fn ($row) => [
                'ds' => $row->ds,
                'rooms_booked' => max(0, (int) $row->rooms_booked),
            ])
            ->values()
            ->all();
    }
}
