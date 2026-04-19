<?php

namespace App\Console\Commands;

use App\Services\ForecastService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class WarmupForecastCache extends Command
{
    protected $signature = 'ai:warmup-forecast-cache {--horizon=30} {--limit=50}';

    protected $description = 'Warm AI forecast cache for hotels to make analysis endpoint fast';

    public function __construct(private readonly ForecastService $forecastService)
    {
        parent::__construct();
    }

    public function handle(): int
    {
        $horizon = (int) $this->option('horizon');
        $limit = (int) $this->option('limit');

        $hotels = DB::table('hotels')
            ->select('id', 'name')
            ->orderBy('id', 'asc')
            ->limit($limit)
            ->get();

        if ($hotels->isEmpty()) {
            $this->warn('Không có khách sạn nào để warmup cache.');
            return self::SUCCESS;
        }

        foreach ($hotels as $hotel) {
            $hotelIdInput = (string) $hotel->name;

            $capacity = (int) DB::table('rooms')
                ->where('hotel_id', $hotel->id)
                ->sum('quantity');

            if ($capacity <= 0) {
                $capacity = ForecastService::DEFAULT_HOTEL_CAPACITY;
            }

            $cacheKey = $this->forecastService->buildCacheKey($hotelIdInput, $capacity, $horizon);

            $result = $this->forecastService->generateForecast($hotelIdInput, $capacity, $horizon);

            if ($result['ok']) {
                $this->forecastService->storeCachedForecast($cacheKey, $result['body'], 300);
                $this->info("Warmup OK: {$hotel->name}");
            } else {
                $this->warn("Warmup FAIL: {$hotel->name} | status={$result['status']}");
            }
        }

        return self::SUCCESS;
    }
}
