<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Thông báo yêu cầu hỗ trợ mới</title>
    <style>
        body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .header { background: #dc3545; color: white; padding: 20px; text-align: center; }
        .content { background: #f9f9f9; padding: 20px; }
        .ticket-info { background: white; padding: 15px; border-left: 4px solid #dc3545; margin: 15px 0; }
        .urgent { border-left-color: #dc3545 !important; background: #fff5f5; }
        .high { border-left-color: #fd7e14; }
        .medium { border-left-color: #ffc107; }
        .low { border-left-color: #28a745; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚨 Yêu cầu hỗ trợ mới</h1>
        </div>

        <div class="content">
            <p><strong>Admin thân mến,</strong></p>
            <p>Có một yêu cầu hỗ trợ mới cần được xử lý:</p>

            <div class="ticket-info {{ $ticket->priority }}">
                <h3>{{ $ticket->subject }}</h3>
                <p><strong>Mã số:</strong> {{ $ticket->ticket_number }}</p>
                <p><strong>Khách hàng:</strong> {{ $ticket->name }} ({{ $ticket->email }})</p>
                <p><strong>Mức độ ưu tiên:</strong>
                    <span style="color:
                        @if($ticket->priority == 'urgent') #dc3545
                        @elseif($ticket->priority == 'high') #fd7e14
                        @elseif($ticket->priority == 'medium') #ffc107
                        @else #28a745
                        @endif
                    ; font-weight: bold;">
                        {{ $priorityLabel }}
                    </span>
                </p>
                <p><strong>Thời gian:</strong> {{ $ticket->created_at->format('d/m/Y H:i:s') }}</p>
                <p><strong>Nội dung:</strong><br>{{ $ticket->message }}</p>
            </div>

            <p>
                <a href="{{ url('/admin/support/' . $ticket->id) }}"
                   style="background: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px; display: inline-block;">
                   Xem chi tiết trong Admin Panel
                </a>
            </p>
        </div>
    </div>
</body>
</html>
