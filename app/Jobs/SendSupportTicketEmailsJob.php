<?php

namespace App\Jobs;

use App\Mail\AdminNotification;
use App\Mail\SupportTicketCreated;
use App\Models\SupportTicket;
use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

class SendSupportTicketEmailsJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $timeout = 120;
    public int $tries = 3;

    public function __construct(private readonly int $ticketId)
    {
    }

    public function handle(): void
    {
        $ticket = SupportTicket::find($this->ticketId);
        if (!$ticket) {
            Log::warning("SupportTicket not found: {$this->ticketId}");
            return;
        }

        Mail::to($ticket->email)->send(new SupportTicketCreated($ticket));

        $admin = User::where('role', 1)->first();
        if ($admin) {
            Mail::to($admin->email)->send(new AdminNotification($ticket));
        }
    }
}
