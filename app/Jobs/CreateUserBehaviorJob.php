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

    protected $data;
    public function __construct(array $data)
    {
       $this->data=$data;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        try {
            UserBehavior::create($this->data);
        } catch (\Throwable $th) {
            Log::error("Error creating user behavior: ".$th->getMessage());
        }
    }
}
