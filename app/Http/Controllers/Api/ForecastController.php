<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\ForecastService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ForecastController extends Controller
{
    public function __construct(private readonly ForecastService $forecastService)
    {
    }

    /**
     * Flow chuẩn mới: chỉ gửi daily delta (ngày hôm qua) sang AI.
     */
    public function forecast(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'hotel_id' => 'required',
            'hotel_capacity' => 'nullable|integer|min:1',
            'horizon_days' => 'nullable|integer|min:1|max:90',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Dữ liệu đầu vào không hợp lệ.',
                'errors' => $validator->errors(),
            ], 422);
        }

        $hotelIdInput = (string) $request->input('hotel_id');
        $hotelCapacity = (int) $request->input('hotel_capacity', ForecastService::DEFAULT_HOTEL_CAPACITY);
        $horizonDays = (int) $request->input('horizon_days', ForecastService::DEFAULT_HORIZON_DAYS);

        $resolved = $this->forecastService->resolveHotel($hotelIdInput);
        $hotelRef = $resolved['hotel_ref'];

        $cached = $this->forecastService->getLatestCachedResult($hotelRef, $horizonDays, 'daily_delta');
        if ($cached) {
            return response()->json($cached, 200);
        }

        $result = $this->forecastService->generateForecastDailyDelta($hotelIdInput, $hotelCapacity, $horizonDays);

        return response()->json($result['body'], $result['status']);
    }

    /**
     * Optional bootstrap: gửi full historical data 60-180 ngày cho hotel mới.
     */
    public function bootstrapForecast(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'hotel_id' => 'required',
            'hotel_capacity' => 'nullable|integer|min:1',
            'horizon_days' => 'nullable|integer|min:1|max:90',
            'history_days' => 'nullable|integer|min:7|max:180',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Dữ liệu đầu vào không hợp lệ.',
                'errors' => $validator->errors(),
            ], 422);
        }

        $hotelIdInput = (string) $request->input('hotel_id');
        $hotelCapacity = (int) $request->input('hotel_capacity', ForecastService::DEFAULT_HOTEL_CAPACITY);
        $horizonDays = (int) $request->input('horizon_days', ForecastService::DEFAULT_HORIZON_DAYS);
        $historyDays = (int) $request->input('history_days', 180);

        $result = $this->forecastService->generateForecastBootstrap(
            $hotelIdInput,
            $hotelCapacity,
            $horizonDays,
            $historyDays,
        );

        return response()->json($result['body'], $result['status']);
    }
}
