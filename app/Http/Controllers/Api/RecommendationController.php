<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Recommendation;
use App\Models\UserBehavior;
use App\Services\RecommendationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class RecommendationController extends Controller
{
    public function getRecommendations($user_id)
    {
        $rec = Recommendation::where('user_id', $user_id)->first();

        if ($rec) {
            $data = json_decode($rec->data, true);

            // Lấy danh sách hotel_id từ AI
            $hotelIds = collect($data)->pluck('hotel_id')->toArray();

            // Lấy thông tin khách sạn kèm hình ảnh
            $hotels = Hotel::whereIn('id', $hotelIds)
                ->with('images')
                ->get();

            // Giữ thứ tự giống AI trả về
            $sortedHotels = $hotels->sortBy(function ($hotel) use ($hotelIds) {
                return array_search($hotel->id, $hotelIds);
            })->values();

            return response()->json([
                'source' => 'AI',
                'data' => $sortedHotels
            ]);
        }

        // fallback top hotels
        $recentHotelIds = UserBehavior::where('user_id', $user_id)
        ->orderBy('timestamp', 'desc')
        ->pluck('hotel_id')
        ->unique()
        ->take(5)
        ->values()
        ->toArray();


        if (empty($recentHotelIds)) {
            $hotels = Hotel::with('images')
                ->orderBy('hotel_class', 'desc') // sắp xếp từ cao xuống thấp
                ->take(5)
                ->get();

            return response()->json([
                'source' => 'default',
                'data' => $hotels
            ]);
        }

        // Lấy danh sách hotel tương ứng theo ID
        $hotels = Hotel::whereIn('id', $recentHotelIds)
        ->with('images')
        ->get();
        $hotels->transform(function ($hotel) {
            $hotel->price_formatted = number_format($hotel->price, 0, ',', '.');
            return $hotel;
        });
        return response()->json([
            'source' => 'default',
            'data' => $hotels
        ]);
    }
}
