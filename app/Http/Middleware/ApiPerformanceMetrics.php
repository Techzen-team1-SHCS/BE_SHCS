<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;

class ApiPerformanceMetrics
{
    public function handle(Request $request, Closure $next): Response
    {
        $start = microtime(true);
        $response = $next($request);
        $durationMs = (microtime(true) - $start) * 1000;

        $key = 'metrics:latency:' . $request->method() . ':' . $request->path();
        $samples = Cache::get($key, []);
        $samples[] = $durationMs;
        $samples = array_slice($samples, -100);
        sort($samples);
        Cache::put($key, $samples, now()->addMinutes(10));

        $p95Index = max((int) floor(count($samples) * 0.95) - 1, 0);
        $p95 = $samples[$p95Index] ?? $durationMs;

        Log::info('api_latency_metric', [
            'path' => $request->path(),
            'method' => $request->method(),
            'status' => $response->getStatusCode(),
            'duration_ms' => round($durationMs, 2),
            'p95_ms' => round((float) $p95, 2),
        ]);

        return $response;
    }
}
