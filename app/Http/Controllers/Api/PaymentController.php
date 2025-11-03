<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Payment;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    protected $vnp_TmnCode = "F9KUTE06"; // từ config của bạn
    protected $vnp_HashSecret = "LLBHCABD51A4EON9R4JJAJZBCV8RJWIG"; // secret của bạn
    protected $vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
    protected $vnp_Returnurl = "http://localhost:8000/api/auth/vnpay/return";

    public function createPayment(Request $request)
{
    date_default_timezone_set('Asia/Ho_Chi_Minh');

    $booking = Booking::findOrFail($request->booking_id);
    
    if ($booking->status === 'confirmed') {
        return response()->json(['status' => 'error', 'message' => 'Booking đã thanh toán']);
    }

    $vnp_TxnRef = $booking->id . '_' . time();
    $vnp_Amount = (int)($booking->total_price * 100);
    $vnp_IpAddr = $request->ip();

    // Các tham số BẮT BUỘC theo VNPay docs
    $inputData = [
        "vnp_Version" => "2.1.0",
        "vnp_TmnCode" => $this->vnp_TmnCode,        // ✅ Bắt buộc
        "vnp_Amount" => $vnp_Amount,                // ✅ Bắt buộc
        "vnp_Command" => "pay",
        "vnp_CreateDate" => date('YmdHis'),
        "vnp_CurrCode" => "VND",
        "vnp_IpAddr" => $vnp_IpAddr,
        "vnp_Locale" => "vn",
        "vnp_OrderInfo" => "Thanh toan GD:" . $vnp_TxnRef, // ✅ Bắt buộc
        "vnp_OrderType" => "other",
        "vnp_ReturnUrl" => $this->vnp_Returnurl,
        "vnp_TxnRef" => $vnp_TxnRef,                // ✅ Bắt buộc
        "vnp_ExpireDate" => date('YmdHis', strtotime('+15 minutes')),
        // "vnp_BankCode" => "NCB", // ❌ KHÔNG được gửi bank code từ đầu (để user chọn)
    ];

    // Sắp xếp theo key
    ksort($inputData);

    // Build query string và hash data
    $query = '';
    $hashData = '';
    $i = 0;

    foreach ($inputData as $key => $value) {
        if ($i == 1) {
            $hashData .= '&' . urlencode($key) . "=" . urlencode($value);
        } else {
            $hashData .= urlencode($key) . "=" . urlencode($value);
            $i = 1;
        }
        $query .= urlencode($key) . "=" . urlencode($value) . '&';
    }

    // QUAN TRỌNG: Sửa các biến chưa định nghĩa
    $vnpSecureHash = hash_hmac('sha512', $hashData, $this->vnp_HashSecret);
    $vnp_Url = $this->vnp_Url . "?" . $query . "vnp_SecureHash=" . $vnpSecureHash;

    \Log::info('VNPay URL Generated', [
        'booking_id' => $booking->id,
        'hash_data' => $hashData,
        'secure_hash' => $vnpSecureHash, // ✅ Đã sửa tên biến
        'url' => $vnp_Url,
    ]);

    // Tạo record Payment
    Payment::create([
        'booking_id' => $booking->id,
        'amount' => $booking->total_price,
        'status' => 'pending',
        'payment_method' => 'vnpay',
        'vnp_txn_ref' => $vnp_TxnRef,
    ]);

    return response()->json(['payment_url' => $vnp_Url]);
}
  public function vnpayReturn(Request $request)
{
    \Log::info('====== VNPay RETURN START ======');
    \Log::info('All return data:', $request->all());

    try {
        $vnp_SecureHash = $request->vnp_SecureHash;

        if (!$vnp_SecureHash) {
            \Log::error('Missing vnp_SecureHash');
            return response()->json([
                'status' => 'error',
                'message' => 'Thiếu chữ ký bảo mật'
            ], 400);
        }

        $inputData = [];
        foreach ($request->all() as $key => $value) {
            if (substr($key, 0, 4) === "vnp_") {
                $inputData[$key] = $value;
            }
        }

        unset($inputData['vnp_SecureHash'], $inputData['vnp_SecureHashType']);

        ksort($inputData);

        $i = 0;
        $hashData = "";
        foreach ($inputData as $key => $value) {
            if ($i == 1) {
                $hashData .= '&' . urlencode($key) . "=" . urlencode($value);
            } else {
                $hashData .= urlencode($key) . "=" . urlencode($value);
                $i = 1;
            }
        }

        $secureHash = hash_hmac('sha512', $hashData, $this->vnp_HashSecret);

        \Log::info('Hash verification:', [
            'our_hash' => $secureHash,
            'vnpay_hash' => $vnp_SecureHash,
            'hash_match' => ($secureHash === $vnp_SecureHash)
        ]);

        if ($secureHash !== $vnp_SecureHash) {
            \Log::error('Invalid VNPay signature');
            return response()->json([
                'status' => 'error',
                'message' => 'Sai chữ ký bảo mật'
            ], 400);
        }

        $vnp_TxnRef = $request->vnp_TxnRef;
        $vnp_ResponseCode = $request->vnp_ResponseCode;
        $vnp_TransactionNo = $request->vnp_TransactionNo;
        $vnp_Amount = $request->vnp_Amount / 100;

        \Log::info('Transaction details:', compact('vnp_TxnRef', 'vnp_ResponseCode', 'vnp_TransactionNo', 'vnp_Amount'));

        $payment = Payment::where('vnp_txn_ref', $vnp_TxnRef)->first();

        if (!$payment) {
            \Log::error('Payment not found for vnp_TxnRef: ' . $vnp_TxnRef);
            return response()->json([
                'status' => 'error',
                'message' => 'Không tìm thấy thông tin thanh toán'
            ], 404);
        }

        if ($payment->status === 'paid') {
            \Log::warning('Payment already processed as paid');
            return response()->json([
                'status' => 'success',
                'message' => 'Giao dịch đã được xử lý thành công trước đó'
            ]);
        }

        if ($vnp_ResponseCode == '00') {
            $payment->update([
                'status' => 'paid',
                'vnp_response_code' => $vnp_ResponseCode,
                'vnp_transaction_no' => $vnp_TransactionNo,
                'vnp_bank_code' => $request->vnp_BankCode ?? null,
                'vnp_bank_tran_no' => $request->vnp_BankTranNo ?? null,
                'vnp_card_type' => $request->vnp_CardType ?? null,
                'vnp_pay_date' => $request->vnp_PayDate ?? null,
            ]);

            $booking = $payment->booking;
            if ($booking) {
                $booking->update([
                    'status' => 'confirmed',
                    'payment_status' => 'paid'
                ]);
            }

            \Log::info('Payment successful:', [
                'payment_id' => $payment->id,
                'booking_id' => $booking ? $booking->id : null,
                'transaction_no' => $vnp_TransactionNo
            ]);

            $redirectUrl = 'http://localhost:5173/payment-result?status=success&transactionId=' . $vnp_TxnRef . '&bookingId=' . ($booking->id ?? '');
            return redirect()->to($redirectUrl);

        } else {
            $payment->update([
                'status' => 'failed',
                'vnp_response_code' => $vnp_ResponseCode,
            ]);

            $errorMessages = [
                '07' => 'Giao dịch bị nghi ngờ (lừa đảo)',
                '09' => 'Thẻ/Tài khoản chưa đăng ký Internet Banking',
                '10' => 'Xác thực thông tin thẻ/tài khoản không đúng',
                '11' => 'Đã hết hạn chờ thanh toán',
                '12' => 'Thẻ/Tài khoản bị khóa',
                '13' => 'Sai mật khẩu xác thực (OTP)',
                '24' => 'Khách hàng hủy giao dịch',
                '51' => 'Tài khoản không đủ số dư',
                '65' => 'Tài khoản đã vượt quá hạn mức giao dịch',
                '75' => 'Ngân hàng thanh toán đang bảo trì',
                '79' => 'Sai mật khẩu thanh toán quá số lần quy định',
            ];

            $errorMessage = $errorMessages[$vnp_ResponseCode] ?? 'Thanh toán thất bại (Mã lỗi: ' . $vnp_ResponseCode . ')';

            \Log::warning('Payment failed:', [
                'payment_id' => $payment->id,
                'response_code' => $vnp_ResponseCode,
                'error_message' => $errorMessage
            ]);

            return response()->json([
                'status' => 'failed',
                'message' => $errorMessage,
                'response_code' => $vnp_ResponseCode
            ]);
        }

    } catch (\Exception $e) {
        \Log::error('VNPay return processing error:', [
            'message' => $e->getMessage(),
            'file' => $e->getFile(),
            'line' => $e->getLine()
        ]);

        return response()->json([
            'status' => 'error',
            'message' => 'Lỗi hệ thống khi xử lý kết quả thanh toán'
        ], 500);
    }
}




}
