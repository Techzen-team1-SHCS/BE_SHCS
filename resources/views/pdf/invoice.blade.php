<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Invoice #{{ $booking->id }}</title>
</head>
<body>
    <h1>HÓA ĐƠN ĐẶT PHÒNG</h1>
    <p><strong>Mã đặt phòng:</strong> {{ $booking->id }}</p>
    <p><strong>Tên khách hàng:</strong> {{ $booking->user->name }}</p>
    <p><strong>Khách sạn:</strong> {{ $booking->room->hotel->name }}</p>
    <p><strong>Phòng:</strong> {{ $booking->room->name }}</p>
    <p><strong>Tổng tiền:</strong> {{ number_format($booking->total_price, 0, ',', '.') }} VND</p>
    <p><strong>Ngày thanh toán:</strong> {{ $booking->updated_at->format('d/m/Y H:i') }}</p>
</body>
</html>
