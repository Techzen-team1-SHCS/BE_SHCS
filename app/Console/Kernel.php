<?php

namespace App\Console;

use App\Console\Commands\MakeServiceCommand;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * Define the application's command schedule.
     */
    protected function schedule(Schedule $schedule): void
    {
        $schedule->command('app:auto-update-bookings')->everyFiveMinutes();
        $schedule->command('app:send-pre-checkin-email')->dailyAt('08:00');
    }

    /**
     * Register the commands for the application.
     */
    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');

    }
    protected $commands = [
    \App\Console\Commands\MakeServiceCommand::class,
    \App\Console\Commands\SendPreCheckinEmail::class,
];

}
