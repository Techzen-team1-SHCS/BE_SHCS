<?php

namespace App\Http\Controllers\Api\Admin;

use App\Events\HotelApproved;
use App\Http\Controllers\Controller;
use App\Models\Hotel;
use App\Models\Notification;
use App\Models\Scopes\ApprovedScope;
use Illuminate\Http\Request;

class AdminHotelController extends Controller
{
    public function hotelsPending()
    {
        $hotels=Hotel::withoutGlobalScope(ApprovedScope::class)
        ->where('status','pending')
        ->with('user')
        ->latest()
        ->get();
        return response()->json([
            'status'=>true,
            'data'=>$hotels
        ]);
    }
    public function approveHotel($id)
    {
        $hotel=Hotel::findOrFail($id);
        $hotel->update([
            'status'=>'approved'
        ]);
        Notification::create([
            'user_id' => $hotel->user_id,
            'type' => 'hotel_approved',
            'title' => 'Hotel đã được duyệt',
            'message' => $hotel->name . ' đã được admin duyệt',
            'is_read' => 0,
            'data' => json_encode([
                'hotel_id' => $hotel->id
            ])
        ]);
    
        event(new HotelApproved($hotel));
    
        return response()->json([
            'status' => true,
            'message' => 'Hotel approved'
        ]);
    }
}
