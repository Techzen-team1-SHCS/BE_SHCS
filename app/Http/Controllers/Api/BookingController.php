<?php

namespace App\Http\Controllers\Api;

use App\Events\BookingCreated;
use App\Events\RoomQuantityUpdated;
use App\Http\Controllers\Controller;
use App\Http\Requests\StoreBookingRequest;
use App\Models\Booking;
use App\Models\Notification;
use App\Models\Payment;
use App\Models\Room;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http;
use Illuminate\Validation\Rule;
use App\Helpers\NotificationHelper;
use App\Jobs\ProcessBookingAfterCreation;
use App\Services\BookingService;

class BookingController extends Controller
{
    protected $bookingService;

    public function __construct(BookingService $bookingService)
    {
        $this->bookingService = $bookingService;
    }

    public function index()
    {
        try {
            $bookings = Booking::query()
                ->select('id', 'user_id', 'room_id', 'check_in', 'check_out', 'total_price', 'status', 'payment_status', 'created_at', 'updated_at', 'quantity')
                ->with([
                    'room:id,quantity,max_guest',
                    'user'
                ])
                ->latest()
                ->paginate((int) request('per_page', 20));

            return response()->json([
                'data' => $bookings->items(),
                'pagination' => [
                    'current_page' => $bookings->currentPage(),
                    'last_page' => $bookings->lastPage(),
                    'per_page' => $bookings->perPage(),
                    'total' => $bookings->total(),
                ],
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Failed to fetch bookings'
            ], 500);
        }
    }

    public function show($id)
    {
        $booking = Booking::with(['room', 'room.hotel', 'room.hotel.images'])->findOrFail($id);
        if (!$booking) {
            return response()->json([
                'status' => 404,
                'error'  => 'Booking not found'
            ]);
        }
        return response()->json([
            'status'  => 200,
            'data'    => $booking,
            'success' => 'Get booking successfully'
        ]);
    }

    public function getBookingUser()
    {
        $user = Auth::user();

        $bookings = Booking::with(['room', 'room.hotel', 'room.hotel.images'])
            ->where('user_id', $user->id)
            ->orderBy('created_at', 'desc')
            ->paginate((int) request('per_page', 20));

        if ($bookings->isEmpty()) {
            return response()->json([
                'status'  => 404,
                'message' => 'Không tìm thấy booking nào'
            ], 404);
        }

        return response()->json([
            'status' => 200,
            'data'   => $bookings->items(),
            'pagination' => [
                'current_page' => $bookings->currentPage(),
                'last_page' => $bookings->lastPage(),
                'per_page' => $bookings->perPage(),
                'total' => $bookings->total(),
            ],
        ], 200);
    }

    public function store(StoreBookingRequest $request)
    {
        $result = $this->bookingService->createBooking($request->validated());
        $status = $result['status'];
        unset($result['status']);

        return response()->json($result, $status);
    }

    public function update($id, Request $request)
    {
        $booking = Booking::with(['user', 'room'])->findOrFail($id);
        $this->authorize('update', $booking);
        $request->validate([
            'check_in'     => 'sometimes|date|after_or_equal:today',
            'check_out'    => 'sometimes|date|after:check_in',
            'total_amount' => 'sometimes|numeric|min:0',
            'status'       => ['sometimes', Rule::in(['pending', 'confirmed', 'cancelled', 'completed'])]
        ]);
        $booking->update($request->all());
        return response()->json([
            'status'  => 'success',
            'data'    => $booking,
            'message' => 'Cập nhật Booking thành công'
        ]);
    }

    public function destroy($id)
    {
        $booking = Booking::find($id);
        $this->authorize('delete', $booking);
        if (!$booking) {
            return response()->json(['message' => 'Booking not found'], 404);
        }
        $booking->delete();
        return response()->json(['message' => 'Booking deleted']);
    }

    public function cancel($id)
    {
        DB::beginTransaction();

        try {
            $booking = Booking::with('room.hotel', 'user')->find($id);
            $this->authorize('delete', $booking);

            if (!$booking) {
                return response()->json(['success' => false, 'message' => 'Booking not found'], 404);
            }

            if ($booking->status === 'cancelled') {
                return response()->json(['success' => false, 'message' => 'Booking is already cancelled'], 400);
            }

            $now             = Carbon::now();
            $checkIn         = Carbon::parse($booking->check_in);
            $cancelFreeDays  = $booking->cancel_free_days ?? 3;
            $diffDays        = $now->diffInDays($checkIn, false);

            if ($now->isSameDay($checkIn)) {
                $diffDays = 0;
            }

            $cancelData = $this->bookingService->buildCancellationData(
                (int) $booking->total_price,
                (int) $diffDays,
                (int) $cancelFreeDays
            );
            $cancelFee = $cancelData['cancel_fee'];
            $refundAmount = $cancelData['refund_amount'];
            $isFree = $cancelData['is_free'];

            $room = Room::where('id', $booking->room_id)->lockForUpdate()->first();
            if (!$room) {
                throw new \Exception("Room not found for booking #{$booking->id}");
            }

            $newQuantity = max($room->quantity + $booking->quantity, 0);
            $room->update(['quantity' => $newQuantity]);

            $booking->update([
                'status'         => 'cancelled',
                'cancel_fee'     => $cancelFee,
                'cancelled_at'   => now(),
                'payment_status' => $refundAmount > 0 ? 'refunded' : 'not_refunded'
            ]);

            // 🔹 Khôi phục trạng thái các RoomNumber cụ thể thành 'available'
            if ($booking->selected_room_numbers) {
                $roomNumArray = explode(',', $booking->selected_room_numbers);
                $roomNumArray = array_map('trim', $roomNumArray);

                \App\Models\RoomNumber::where('room_id', $booking->room_id)
                    ->whereIn('room_number', $roomNumArray)
                    ->update(['status' => 'available']);
            }

            if ($refundAmount > 0 && $booking->user) {
                $booking->user->wallet_balance += $refundAmount;
                $booking->user->save();
            }

            // 🟡 Notify USER: hủy booking thành công
            NotificationHelper::send(
                $booking->user_id,
                'cancel_booking',
                'Hủy phòng thành công',
                "Booking #{$booking->id} đã được hủy. Phí hủy: "
                    . number_format($cancelFee, 0, ',', '.') . ' VND. Hoàn lại: '
                    . number_format($refundAmount, 0, ',', '.') . ' VND.',
                ['booking_id' => $booking->id]
            );

            // 🟡 Notify HOTEL MANAGER: khách hủy booking
            $hotelOwnerId = optional(optional($booking->room)->hotel)->user_id;
            if ($hotelOwnerId && $hotelOwnerId !== $booking->user_id) {
                NotificationHelper::send(
                    $hotelOwnerId,
                    'booking_cancelled',
                    '⚠️ Khách hủy booking',
                    "Booking #{$booking->id} đã bị hủy bởi khách. Phòng trống trở lại: {$newQuantity}.",
                    ['booking_id' => $booking->id, 'available_quantity' => $newQuantity]
                );
            }

            DB::commit();
            Cache::forget('dashboard_stats');
            Cache::forget('dashboard_summary');

            return response()->json([
                'success' => true,
                'message' => $isFree
                    ? 'Hủy phòng thành công, không mất phí.'
                    : 'Hủy phòng thành công, phí hủy: ' . number_format($cancelFee, 0, ',', '.') . ' VND.',
                'data' => [
                    'booking'            => $booking->load(['user', 'room']),
                    'cancel_fee'         => $cancelFee,
                    'refund_amount'      => $refundAmount,
                    'is_free'            => $isFree,
                    'available_quantity' => $newQuantity,
                ]
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Lỗi hủy booking #{$id}: " . $e->getMessage());

            return response()->json([
                'success' => false,
                'message' => 'Failed to cancel booking',
                'error'   => $e->getMessage()
            ], 500);
        }
    }

    public function processCancelledBookings()
    {
        $bookings = Booking::where('status', 'cancelled')
            ->where('payment_status', 'paid')
            ->whereNull('cancel_fee')
            ->get();

        foreach ($bookings as $booking) {
            try {
                DB::beginTransaction();

                $today    = Carbon::now();
                $checkIn  = Carbon::parse($booking->check_in);
                $diffDays = $today->diffInDays($checkIn);

                if ($diffDays > $booking->cancel_free_days) {
                    $cancelFee    = 0;
                    $refundAmount = $booking->total_price;
                } elseif ($diffDays > 0 && $diffDays <= $booking->cancel_free_days) {
                    $cancelFee    = round($booking->total_price * 0.5);
                    $refundAmount = $booking->total_price - $cancelFee;
                } else {
                    $cancelFee    = $booking->total_price;
                    $refundAmount = 0;
                }

                $booking->update([
                    'cancel_fee'     => $cancelFee,
                    'payment_status' => $refundAmount > 0 ? 'refunded' : 'not_refunded',
                ]);

                if ($refundAmount > 0) {
                    $user = $booking->user;
                    if ($user) {
                        $user->wallet_balance += $refundAmount;
                        $user->save();
                        Log::info("Booking #{$booking->id}: Refund {$refundAmount} VND added to user #{$user->id} wallet");
                    }
                }

                DB::commit();
            } catch (\Exception $e) {
                DB::rollBack();
                Log::error("Lỗi xử lý hoàn tiền booking #{$booking->id}: " . $e->getMessage());
            }
        }

        return response()->json([
            'status'  => 'success',
            'message' => 'Đã xử lý các booking hủy theo quy định'
        ]);
    }

    public function getRealtimeQuantity($id)
    {
        $room = Room::find($id);
        if (!$room) {
            return response()->json(['message' => 'Room not found'], 404);
        }

        return response()->json([
            'success'            => true,
            'room_id'            => $room->id,
            'available_quantity' => $room->quantity,
            'room_type'          => $room->room_type,
            'price'              => $room->price,
            'last_updated'       => now()->toISOString()
        ]);
    }

    public function generateQR(Request $request)
    {
        $booking = Booking::findOrFail($request->booking_id);
        $amount = (int) $booking->total_price;
        if ($booking->status === 'completed' || $booking->payment_status === 'paid') {
            return response()->json(['status' => 'error', 'message' => 'Booking đã thanh toán']);
        }
        
        $orderCode = $booking->payment_code;
        if (!$orderCode) {
            $orderCode = $booking->getOrGeneratePaymentCode();
        }
        
        $bankBin = env('BANK_ID', '970422'); 
        $accountNo = env('ACCOUNT_NO', '0935326193'); 
        $template = env('TEMPLATE', 'compact2');
        $accountName = env('ACCOUNT_NAME', 'TEN CHU THE'); 
     
        $response = Http::timeout(8)->retry(2, 200)->post('https://api.vietqr.io/v2/generate', [
            'accountNo' => $accountNo,
            'accountName' => $accountName,
            'acqId' => $bankBin,
            'amount' => $amount,
            'addInfo' => $orderCode, 
            'format' => 'text',
            'template' => $template 
        ]);
        
        if ($response->successful()) {
            $data = $response->json();
            $data['payment_info'] = [
                'accountNo' => $accountNo,
                'accountName' => $accountName,
                'amount' => $amount,
                'addInfo' => $orderCode
            ];
            return response()->json($data);
        }
        return response()->json(['error' => 'Không thể tạo mã QR'], 500);
    }
}
