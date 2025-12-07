<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreDiscountRequest;
use App\Models\Booking;
use App\Models\Discount;
use Error;
use Illuminate\Http\Request;

class DiscountController extends Controller
{
    public function index(){
        try {
            $discount=Discount::all();
            if(!$discount){
                return response()->json([
                    'status'=>404,
                    'error'=>'Not found'
                ]);
            }
            return response()->json([
                'status'=>200,
                'data'=>$discount
            ]);
        } catch (\Throwable $th) {
            throw new Error('errot'.$th->getMessage());
        }
    }
    public function store(StoreDiscountRequest $request){
        try {
            $validated=$request->validated();
            $discount=Discount::create($validated);
            return response()->json([
                'status'=>200,
                'data'=>$discount
            ]);
        } catch (\Throwable $th) {
            throw $th;
        }
    }
    public function applyDiscount(Request $request, $id)
    {
        $request->validate([
            'discount_code' => 'required|string'
        ]);

        // Lấy booking
        $booking = Booking::find($id);
        if (!$booking) {
            return response()->json(['message' => 'Booking not found'], 404);
        }

        // Lấy mã giảm giá
        $discount = Discount::where('code', $request->discount_code)
            ->where('isActive', true)
            ->first();

        if (!$discount) {
            return response()->json(['message' => 'Mã giảm giá không tồn tại hoặc đã hết hạn'], 400);
        }

        // Kiểm tra hạn sử dụng
        if ($discount->expiryDate < now()->toDateString()) {
            return response()->json(['message' => 'Mã giảm giá đã hết hạn'], 400);
        }

        // Kiểm tra đơn tối thiểu
        if ($booking->total_price < $discount->minOrder) {
            return response()->json([
                'message' => 'Đơn hàng chưa đạt mức tối thiểu để áp dụng mã này'
            ], 400);
        }

        // Tính giảm giá
        $valuePercent = (int) str_replace('%', '', $discount->value); // "20%" -> 20

        $discountAmount = intval($booking->total_price * ($valuePercent / 100));

        // Giới hạn giảm tối đa
        if ($discount->maxDiscount && $discountAmount > $discount->maxDiscount) {
            $discountAmount = $discount->maxDiscount;
        }

        // Tính final price
        $finalPrice = $booking->total_price - $discountAmount;

        // Lưu vào DB
        $booking->update([
            'discount_code' => $discount->code,
            'discount_amount' => $discountAmount,
            'final_price' => $finalPrice,
        ]);

        return response()->json([
            'message' => 'Áp mã giảm giá thành công!',
            'discount_amount' => $discountAmount,
            'final_price' => $finalPrice,
            'booking' => $booking
        ]);
    }

}
