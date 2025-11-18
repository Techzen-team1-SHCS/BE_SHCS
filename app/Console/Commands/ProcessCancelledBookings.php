<?php

namespace App\Console\Commands;

use App\Http\Controllers\Api\BookingController;
use Illuminate\Console\Command;

class ProcessCancelledBookings extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'app:process-cancelled-bookings';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        app(BookingController::class)->processCancelledBookings();
    }
}
