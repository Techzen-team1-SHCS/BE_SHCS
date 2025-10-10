<?php

namespace App\Notifications;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Notifications\Messages\MailMessage;
use Illuminate\Notifications\Notification;

class Customresetpassword extends Notification
{
    use Queueable;

    protected $token; // 👈 thêm dòng này

    /**
     * Create a new notification instance.
     */
    public function __construct($token) // 👈 nhận token
    {
        $this->token = $token; // 👈 gán token
    }

    /**
     * Get the notification's delivery channels.
     */
    public function via($notifiable)
    {
        return ['mail'];
    }

    /**
     * Get the mail representation of the notification.
     */
    public function toMail($notifiable)
    {
        $frontendUrl = env('FRONTEND_URL', 'http://localhost:5173');

        $resetUrl = "{$frontendUrl}/reset-password/{$this->token}?email={$notifiable->email}";

        return (new MailMessage)
            ->subject('Đặt lại mật khẩu của bạn')
            ->greeting('Xin chào!')
            ->line('Bạn đã yêu cầu đặt lại mật khẩu cho tài khoản của mình.')
            ->action('Đặt lại mật khẩu', $resetUrl)
            ->line('Liên kết này sẽ hết hạn sau 60 phút.')
            ->line('Nếu bạn không yêu cầu, vui lòng bỏ qua email này.');
    }

    public function toArray($notifiable)
    {
        return [];
    }
}
