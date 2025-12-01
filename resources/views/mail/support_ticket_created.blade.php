<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Xác nhận yêu cầu hỗ trợ</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 30px; text-align: center; }
        .content { background: #f9f9f9; padding: 30px; }
        .ticket-info { background: white; padding: 20px; border-radius: 8px; margin: 20px 0; }
        .footer { text-align: center; padding: 20px; color: #666; font-size: 14px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Yêu cầu hỗ trợ đã được tiếp nhận</h1>
        </div>

        <div class="content">
            <p>Xin chào <strong>{{ $ticket->name }}</strong>,</p>
            <p>Cảm ơn bạn đã liên hệ với chúng tôi. Yêu cầu hỗ trợ của bạn đã được tiếp nhận và sẽ được xử lý trong thời gian sớm nhất.</p>

            <div class="ticket-info">
                <h3>Thông tin yêu cầu:</h3>
                <p><strong>Mã số:</strong> {{ $ticket->ticket_number }}</p>
                <p><strong>Tiêu đề:</strong> {{ $ticket->subject }}</p>
                <p><strong>Mức độ ưu tiên:</strong>
                    @if($ticket->priority == 'urgent') 🚨 Khẩn cấp
                    @elseif($ticket->priority == 'high') 🔴 Cao
                    @elseif($ticket->priority == 'medium') 🟡 Trung bình
                    @else 🟢 Thấp
                    @endif
                </p>
                <p><strong>Nội dung:</strong><br>{{ $ticket->message }}</p>
            </div>

            <p>Chúng tôi sẽ liên hệ với bạn qua email <strong>{{ $ticket->email }}</strong> trong thời gian sớm nhất.</p>
            <p>Trân trọng,<br><strong>Đội ngũ hỗ trợ HotelBooking</strong></p>
        </div>

        <div class="footer">
            <p>© {{ date('Y') }} HotelBooking. All rights reserved.</p>
        </div>
    </div>
</body>
</html>
