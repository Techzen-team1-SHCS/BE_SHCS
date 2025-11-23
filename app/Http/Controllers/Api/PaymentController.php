<?php

namespace App\Http\Controllers\Api;

use App\Helpers\NotificationHelper;
use App\Http\Controllers\Controller;
use App\Mail\PaymentBilling;
use App\Models\Booking;
use App\Models\Payment;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;

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
        if (Carbon::parse($booking->check_out)->isPast()) {
            return response()->json([
                'success' => false,
                'message' => 'Booking này đã hết hạn, không thể thanh toán.'
            ], 400);
        }

        // ❌ Nếu booking bị hủy
        if ($booking->status === 'cancelled') {
            return response()->json([
                'success' => false,
                'message' => 'Booking đã bị hủy, không thể thanh toán.'
            ], 400);
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
        ];
        ksort($inputData);
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
        $vnpSecureHash = hash_hmac('sha512', $hashData, $this->vnp_HashSecret);
        $vnp_Url = $this->vnp_Url . "?" . $query . "vnp_SecureHash=" . $vnpSecureHash;
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
        try {
            $vnp_SecureHash = $request->vnp_SecureHash;

            if (!$vnp_SecureHash) {
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
            if ($secureHash !== $vnp_SecureHash) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Sai chữ ký bảo mật'
                ], 400);
            }

            $vnp_TxnRef = $request->vnp_TxnRef;
            $vnp_ResponseCode = $request->vnp_ResponseCode;
            $vnp_TransactionNo = $request->vnp_TransactionNo;

            $payment = Payment::where('vnp_txn_ref', $vnp_TxnRef)->first();
            if (!$payment) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Không tìm thấy thông tin thanh toán'
                ], 404);
            }

            $booking = $payment->booking; // ✅ Gán booking ngay từ đầu
            $booking->load('user', 'room.hotel');

            if ($payment->status === 'paid') {
                // Nếu đã thanh toán trước đó
                if ($booking) {
                    NotificationHelper::send(
                        $booking->user_id,
                        'payment',
                        'Thanh toán thành công',
                        "Booking #{$booking->id} đã thanh toán thành công: " . number_format($booking->total_price,0,',','.') . " VND"
                    );
                }
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

                if ($booking) {
                    $booking->update([
                        'status' => 'confirmed',
                        'payment_status' => 'paid'
                    ]);

                    // Gửi notification realtime
                    NotificationHelper::send(
                        $booking->user_id,
                        'payment',
                        'Thanh toán thành công',
                        "Booking #{$booking->id} đã thanh toán thành công: " . number_format($booking->total_price,0,',','.') . " VND"
                    );

                    try {
                        // Sinh PDF hóa đơn
                        $pdf = \Barryvdh\DomPDF\Facade\Pdf::loadView('pdf.invoice', compact('booking'));
                        $pdfPath = storage_path('app/public/invoice-' . $booking->id . '.pdf');
                        $pdf->save($pdfPath);

                        // Gửi mail
                        Mail::to($booking->user->email)->send(new PaymentBilling($booking, $pdfPath));
                    } catch (\Exception $e) {
                        Log::error('Send invoice failed: ' . $e->getMessage());
                    }
                }

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
                return response()->json([
                    'status' => 'failed',
                    'message' => $errorMessage,
                    'response_code' => $vnp_ResponseCode
                ]);
            }

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => 'Lỗi hệ thống khi xử lý kết quả thanh toán',
                'error' => $e->getMessage()
            ], 500);
        }
    }


}
