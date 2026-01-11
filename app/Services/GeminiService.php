<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class GeminiService
{
    protected $model = 'models/gemini-2.5-flash';
    protected $apiKey;

    public function __construct()
    {
        $this->apiKey = env('GEMINI_API_KEY');
    }

    public function generateText($prompt)
    {
        $res = Http::post(
            "https://generativelanguage.googleapis.com/v1/{$this->model}:generateContent?key={$this->apiKey}",
            [
                'contents' => [[
                    'parts' => [[ 'text' => $prompt ]]
                ]]
            ]
        )->json();

        return $res['candidates'][0]['content']['parts'][0]['text'] ?? null;
    }
}
