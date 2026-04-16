<?php

namespace App\Services;

use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\Client\RequestException;
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
        try {
            $response = Http::timeout(12)
                ->retry(3, 250, function ($exception) {
                    return $exception instanceof ConnectionException || $exception instanceof RequestException;
                })
                ->post(
                    "https://generativelanguage.googleapis.com/v1/{$this->model}:generateContent?key={$this->apiKey}",
                    [
                        'contents' => [[
                            'parts' => [['text' => $prompt]]
                        ]],
                        'generationConfig' => [
                            'temperature' => 0.2,
                            'topP' => 0.9,
                            'maxOutputTokens' => 260,
                        ],
                    ]
                );

            if (!$response->successful()) {
                return null;
            }

            $res = $response->json();

            return $res['candidates'][0]['content']['parts'][0]['text'] ?? null;
        } catch (\Throwable) {
            return null;
        }
    }
}
