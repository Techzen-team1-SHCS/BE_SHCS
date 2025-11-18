<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nhắc lịch check-in</title>
</head>
<body>
    <h2>Xin chào {{ $customerName }},</h2>

    <p>Chúng tôi xin nhắc lịch check-in của bạn tại <strong>{{ $hotelName }}</strong> như sau:</p>

    <ul>
        <li><strong>Giờ check-in:</strong> {{ $checkInTime }}</li>
        <li><strong>Địa chỉ:</strong> {{ $hotelAddress }}</li>
        <li><strong>Liên hệ lễ tân:</strong> {{ $contactPhone }}</li>
    </ul>

    <p>Vui lòng chuẩn bị để đến đúng giờ. Chúng tôi rất mong được đón tiếp bạn!</p>

    <p>Trân trọng,</p>
    <p><strong>{{ $hotelName }}</strong></p>
</body>
</html>
