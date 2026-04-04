<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Redis;

class LogQueueDepth extends Command
{
    protected $signature = 'metrics:queue-depth';
    protected $description = 'Log Redis queue depth metric';

    public function handle(): int
    {
        try {
            $depth = (int) Redis::llen('queues:default');
            Log::info('queue_depth_metric', ['queue' => 'default', 'depth' => $depth]);
        } catch (\Throwable $e) {
            Log::warning('queue_depth_metric_failed', ['error' => $e->getMessage()]);
        }

        return self::SUCCESS;
    }
}
