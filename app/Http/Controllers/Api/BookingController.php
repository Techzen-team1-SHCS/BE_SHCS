<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class BookingController extends Controller
{
    public function index(){
        $bookings=Booking::with(['user','room'])->orderBy('created_at','desc')->get();
        return response()->json(['data'=>$bookings]);
    }
    public function show($id){
        $booking=Booking::with(['user','room'])->findOrFail($id);
        if(!$booking){
          return response()->json([
            'status'=>404,
            'error'=>'Booking not found'
          ]);
        }
        return response()->json([
            'status'=>200,
            'data'=>$booking,
            'success'=>'Get booking successfully'
        ]);
    }
    public function create(Request $request){
       $request->validate([
        'user_id'=>'required|exists|users,id',
        'room_id'=>'required|exists|rooms,id',
        'check_in' => 'required|date|after_or_equal:today',
        'check_out' => 'required|date|after:check_in',
        'total_price' => 'required|numeric|min:0',
        'quantity'=>'required|numeric|min:1'
       ]);
      $booking= Booking::create([
        'user_id'=>$request->user_id,
        'room_id'=>$request->room_id,
        'check_in'=>$request->check_in,
        'checkout'=>$request->check_out,
        'total_price'=>$request->total_price,
        'status'=>'pending',
        'quantity'=>$request->quantity
       ]);
       return response()->json([
         'success'=>200,
         'data'=>$booking,
         'message'=>'Đặt phòng Thành Công'
       ]);
    }
    public function update($id,Request $request){
        $booking=Booking::with(['user','room'])->findOrFail($id);
        $request->validate([
            'check_in' => 'sometimes|date|after_or_equal:today',
            'check_out' => 'sometimes|date|after:check_in',
            'total_amount' => 'sometimes|numeric|min:0',
            'status' => ['sometimes', Rule::in(['pending','confirmed','cancelled'])]
        ]);
        $booking->update($request->all());
        return response()->json([
            'status'=>'success',
            'data'=>$booking,
            'message'=>'Cập nhật Booking thành công'
        ]);
    }
    public function destroy($id){
        $booking=Booking::find($id);
        if(!$booking){
            return response()->json([
                'message'=>'Booking not found'
            ],404);
        }
        $booking->delete();
        return response()->json([
            'message'=>'Booking deleted'
        ]);
    }


}
