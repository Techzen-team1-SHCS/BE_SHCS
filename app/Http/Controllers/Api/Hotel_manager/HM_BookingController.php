<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Hotel;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class HM_BookingController extends Controller
{
    public function bookings($id)
    {
        $hotel=Hotel::findOrFail($id);
        $this->authorize('viewHotelBookings',$hotel);
        $bookings=Booking::where('hotel_id',$hotel->id)
        ->with(['user','room'])
        ->latest()
        ->get();
        return response()->json([
            'status'=>true,
            'data'=>$bookings
        ]);
    }
    public function update_booking_status($id,Request $request)
    {
        $booking=Booking::findOrFail($id);
        $this->authorize('update',$booking);
        $request->validate([
            'status'=>['required',Rule::in(['confirmed','cancelled'])]
        ]);
        $booking->update([
            'status'=>$request->status
        ]);
        return response()->json([
            'status'=>true,
            'message'=>'Cập nhật trạng thái booking thành công',
            'data'=>$booking
        ]);
    }
}
