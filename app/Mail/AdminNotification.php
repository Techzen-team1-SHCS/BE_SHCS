<?php

namespace App\Mail;

use App\Models\SupportTicket;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class AdminNotification extends Mailable
{
    use Queueable, SerializesModels;

    public $ticket;

    public function __construct(SupportTicket $ticket)
    {
        $this->ticket = $ticket;
    }

    public function build()
    {
        $priorityLabels = [
            'low' => 'Thấp',
            'medium' => 'Trung bình',
            'high' => 'Cao',
            'urgent' => 'Khẩn cấp'
        ];

        return $this->subject('🚨 Yêu cầu hỗ trợ mới: ' . $this->ticket->subject)
                    ->view('mail.admin_notification')
                    ->with([
                        'ticket' => $this->ticket,
                        'priorityLabel' => $priorityLabels[$this->ticket->priority]
                    ]);
    }
}
