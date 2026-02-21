<?php

namespace App\Http\Controllers\Api\Admin;

use App\Http\Controllers\Controller;
use App\Models\Notification;
use Illuminate\Http\Request;

class AdminNotificationController extends Controller
{
    public function adminNotifications(){
        $user=Auth()->user();
        $notifications=Notification::where('user_id',$user->id)
            ->latest()
            ->get();
        return response()->json([
            'status'=>true,
            'data'=>$notifications
        ]);
    }
}
