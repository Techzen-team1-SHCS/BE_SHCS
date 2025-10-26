<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class RecommendationService
{
    public function getFromAI($user_id)
    {
        try {
            // Gọi sang Python AI server
            $response = Http::timeout(5)->get("http://localhost:5000/recommend/$user_id");

            if ($response->successful()) {
                return $response->json()['data'] ?? [];
            }

            return [];
        } catch (\Exception $e) {
            Log::error("AI recommendation error: " . $e->getMessage());
            return [];
        }
    }
}
