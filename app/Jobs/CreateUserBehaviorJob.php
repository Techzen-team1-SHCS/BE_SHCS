<?php

namespace App\Jobs;

use App\Models\UserBehavior;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class CreateUserBehaviorJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $log;
    public function __construct(array $log)
    {
       $this->log=$log;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        try {
            Log::info("Saving UserBehavior", $this->log);
            UserBehavior::create([
            'user_id' => $this->log['user_id'] ?? null,
            'hotel_id' => $this->log['hotel_id'] ?? null,
            'action'  => $this->log['action'],
            'metadata'=> isset($this->log['metadata']) ? json_encode($this->log['metadata']) : null,
            'is_sent'=>false
        ]);
        } catch (\Throwable $th) {
            Log::error("Error creating user behavior: ".$th->getMessage());
        }
    }
}
