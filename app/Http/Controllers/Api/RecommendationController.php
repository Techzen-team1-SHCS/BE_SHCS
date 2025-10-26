<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Services\RecommendationService;
use Illuminate\Http\Request;

class RecommendationController extends Controller
{
     protected $recommendationService;

    public function __construct(RecommendationService $recommendationService)
    {
        $this->recommendationService = $recommendationService;
    }

    public function getRecommendations($user_id)
    {
        // Gọi sang AI service
        $recommendations = $this->recommendationService->getFromAI($user_id);

        // Nếu AI không trả dữ liệu, fallback top hotels
        if (!$recommendations || count($recommendations) === 0) {
            $recommendations = Hotel::orderBy('rating', 'desc')->take(5)->get();
            return response()->json([
                'source' => 'default',
                'data' => $recommendations
            ]);
        }

        return response()->json([
            'source' => 'AI',
            'data' => $recommendations
        ]);
    }
}
