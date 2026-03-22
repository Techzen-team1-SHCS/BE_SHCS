<?php

namespace App\Http\Controllers\Api\Admin;

use App\Events\HotelApproved;
use App\Events\HotelRejected;
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
        $hotel=Hotel::withoutGlobalScope(ApprovedScope::class)->findOrFail($id);
        $hotel->update([
            'status'=>'approved'
        ]);

        // Thông báo cho hotel manager
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

        // Thông báo cho admin hiện tại
        $admin = auth()->user();
        Notification::create([
            'user_id' => $admin->id,
            'type' => 'hotel_approved',
            'title' => 'Hotel đã duyệt thành công',
            'message' => 'Bạn đã duyệt thành công khách sạn: ' . $hotel->name,
            'is_read' => 0,
            'data' => json_encode([
                'hotel_id' => $hotel->id,
                'action' => 'approved'
            ])
        ]);

        event(new HotelApproved($hotel));

        return response()->json([
            'status' => true,
            'message' => 'Hotel approved'
        ]);
    }
    public function rejectHotel($id, Request $request)
    {
        $hotel = Hotel::withoutGlobalScope(ApprovedScope::class)->findOrFail($id);
        $hotel->update([
            'status' => 'rejected'
        ]);

        $reason = $request->input('reason', 'Admin không chấp nhận');

        // Thông báo cho hotel manager
        Notification::create([
            'user_id' => $hotel->user_id,
            'type' => 'hotel_rejected',
            'title' => 'Khách sạn bị từ chối',
            'message' => $hotel->name . ' không được phê duyệt. Lý do: ' . $reason,
            'is_read' => 0,
            'data' => json_encode([
                'hotel_id' => $hotel->id,
                'reason' => $reason
            ])
        ]);

        // Thông báo cho admin hiện tại
        $admin = auth()->user();
        Notification::create([
            'user_id' => $admin->id,
            'type' => 'hotel_rejected',
            'title' => 'Hotel đã từ chối thành công',
            'message' => 'Bạn đã từ chối khách sạn: ' . $hotel->name,
            'is_read' => 0,
            'data' => json_encode([
                'hotel_id' => $hotel->id,
                'action' => 'rejected',
                'reason' => $reason
            ])
        ]);

        event(new HotelRejected($hotel, $reason));

        return response()->json([
            'status' => true,
            'message' => 'Hotel rejected'
        ], 200);
    }
}