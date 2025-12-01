<?php

namespace App\Mail;

use App\Models\SupportTicket;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SupportTicketCreated extends Mailable
{
    use Queueable, SerializesModels;

    public $ticket;

    public function __construct(SupportTicket $ticket)
    {
        $this->ticket = $ticket;
    }

    public function build()
    {
        return $this->subject('Xác nhận yêu cầu hỗ trợ #' . $this->ticket->ticket_number)
                    ->view('mail.support_ticket_created')
                    ->with([
                        'ticket' => $this->ticket,
                    ]);
    }
}
