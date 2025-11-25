<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Recommendation;
use App\Models\UserBehavior;
use App\Services\RecommendationService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class RecommendationController extends Controller
{
    public function getRecommendations()
    {
        $user_id = Auth::id();
        $rec = Recommendation::where('user_id', $user_id)->first();

        if ($rec) {
            // AI trả về dạng chuỗi JSON: "[92,428,1,...]"
            $hotelIds = json_decode($rec->data, true);

            // Nếu decode lỗi hoặc AI trả về rỗng
            if (!is_array($hotelIds) || empty($hotelIds)) {
                return response()->json([
                    'source' => 'AI',
                    'data' => []
                ]);
            }

            // Lấy danh sách khách sạn theo ID
            $hotels = Hotel::whereIn('id', $hotelIds)
                ->with('images')
                ->get();

            // Giữ đúng thứ tự mà AI trả về
            $sortedHotels = $hotels->sortBy(function ($hotel) use ($hotelIds) {
                return array_search($hotel->id, $hotelIds);
            })->values();

            // Trả về danh sách khách sạn
            return response()->json([
                'source' => 'AI',
                'data' => $sortedHotels
            ]);
        }
        if (!$user_id) {
            $hotels = Hotel::with('images')
                ->orderBy('hotel_class', 'desc') // sắp xếp từ cao xuống thấp
                ->take(5)
                ->get();
        }
        return response()->json([
            'source' => 'default',
            'data' => $hotels
        ]);
    }
}
