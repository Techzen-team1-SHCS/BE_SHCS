<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hóa đơn đặt phòng</title>
</head>
<body style="font-family: Arial, sans-serif; background-color:#f8f8f8; padding:20px;">

    <div style="max-width:600px;margin:auto;background:#ffffff;border-radius:10px;overflow:hidden;box-shadow:0 2px 8px rgba(0,0,0,0.1);">
        <div style="background-color:#ECC2C0;padding:15px 25px;text-align:center;">
            <img src="{{ $message->embed(public_path('images/logo/logo.png')) }}" alt="Hotel Logo" style="width: 140px;">
            <h2 style="margin:0;color:#2B2B2F;">Cảm ơn bạn đã đặt phòng!</h2>
        </div>

        <div style="padding:25px;">
            <p style="font-size:16px;color:#333;">Xin chào <strong>{{ $booking->user->name }}</strong>,</p>
            <p style="font-size:14px;color:#444;">Cảm ơn bạn đã đặt phòng tại hệ thống của chúng tôi. Dưới đây là thông tin hóa đơn:</p>

            <div style="border:1px solid #E5C7C5; border-radius:10px; background:#F4E2DE; padding:20px; margin-top:20px;">
                <h3 style="margin-top:0;color:#000;font-size:15px;">Billing Details</h3>
                <hr style="border:none;border-top:1px solid #E5C7C5;margin:10px 0;">

                <p style="margin:4px 0;font-size:13px;"><strong>Mã đặt phòng:</strong> {{ $booking->id }}</p>
                <p style="margin:4px 0;font-size:13px;"><strong>Khách sạn:</strong> {{ $booking->room->hotel->name }}</p>
                <p style="margin:4px 0;font-size:13px;"><strong>Phòng:</strong> {{ $booking->room->name }}</p>

                <hr style="border:none;border-top:1px solid #E5C7C5;margin:10px 0;">

                <p style="margin:4px 0;font-size:13px;"><strong>Phương thức thanh toán:</strong> NCB</p>
                <p style="margin:4px 0;font-size:13px;">**** **** **** 2198</p>

                <hr style="border:none;border-top:1px solid #E5C7C5;margin:10px 0;">

                <h4 style="margin-bottom:8px;font-size:13px;">Chi tiết thanh toán</h4>
                <div style="display:flex;justify-content:space-between;font-size:13px;">
                    <span>Tổng tiền phòng:</span>
                    <span>{{ number_format($booking->total_price, 0, ',', '.') }} VND</span>
                </div>
                <div style="display:flex;justify-content:space-between;font-size:13px;">
                    <span>Phí dịch vụ:</span>
                    <span>10.000 VND</span>
                </div>
                <div style="display:flex;justify-content:space-between;font-size:13px;">
                    <span>Thuế:</span>
                    <span>30.000 VND</span>
                </div>
            </div>

            <div style="margin-top:25px;background:#ECC2C0;padding:12px 20px;border-radius:8px;text-align:center;">
                <p style="margin:0;font-size:14px;color:#2B2B2F;"><strong>Ngày đặt:</strong> {{ $booking->created_at->format('d/m/Y H:i') }}</p>
                <p style="margin:6px 0 0;font-size:13px;">File PDF đính kèm là hóa đơn chi tiết của bạn.</p>
            </div>
        </div>

        <div style="text-align:center;padding:15px;font-size:12px;color:#888;">
            © {{ date('Y') }} Hotel Booking. Mọi quyền được bảo lưu.
        </div>
    </div>

</body>
</html>
