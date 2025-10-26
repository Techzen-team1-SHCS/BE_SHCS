<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Recommendation;
use App\Services\RecommendationService;
use Illuminate\Http\Request;

class RecommendationController extends Controller
{
    public function getRecommendations($user_id)
    {
        $rec = Recommendation::where('user_id', $user_id)->first();

        if ($rec) {
            $data = json_decode($rec->data, true);
            return response()->json([
                'source' => 'AI',
                'data' => $data
            ]);
        }

        // fallback top hotels
        $top = Hotel::orderBy('rating', 'desc')->take(5)->get();
        return response()->json([
            'source' => 'default',
            'data' => $top
        ]);
    }
}
