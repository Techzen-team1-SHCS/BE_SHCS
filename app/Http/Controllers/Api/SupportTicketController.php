<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\SupportTicket;
use App\Mail\SupportTicketCreated;
use App\Mail\AdminNotification;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Laravel\Reverb\Loggers\Log;

class SupportTicketController extends Controller
{
    public function store(Request $request)
{
    $validator = Validator::make($request->all(), [
        'name' => 'required|string|max:255',
        'email' => 'required|email|max:255',
        'subject' => 'required|string|max:500',
        'priority' => 'required|in:low,medium,high,urgent',
        'message' => 'required|string|min:10'
    ]);

    if ($validator->fails()) {
        return response()->json([
            'success' => false,
            'message' => 'Validation error',
            'errors' => $validator->errors()
        ], 422);
    }

    try {
        // Tạo ticket
        $ticket = SupportTicket::create($request->all());

        // Gửi email xác nhận cho khách hàng
        Mail::to($request->email)->send(new SupportTicketCreated($ticket));

        // Lấy email của admin (user có role = 1)
        $admin = \App\Models\User::where('role', 1)->first();

        if ($admin) {
            // Gửi thông báo cho admin
            Mail::to($admin->email)->send(new AdminNotification($ticket));
        } else {
            \Log::warning('Không tìm thấy admin user với role = 1');
        }

        return response()->json([
            'success' => true,
            'message' => 'Yêu cầu hỗ trợ đã được gửi thành công!',
            'ticket_number' => $ticket->ticket_number
        ], 201);

    } catch (\Exception $e) {
        \Log::error('Support ticket error: ' . $e->getMessage());
        \Log::error('Error details: ', ['exception' => $e]);

        return response()->json([
            'success' => false,
            'message' => 'Có lỗi xảy ra khi gửi yêu cầu. Vui lòng thử lại sau.'
        ], 500);
    }
}

    public function index()
    {
        $tickets = SupportTicket::orderBy('created_at', 'desc')->get();

        return response()->json([
            'success' => true,
            'data' => $tickets
        ]);
    }

    public function show($id)
    {
        $ticket = SupportTicket::find($id);

        if (!$ticket) {
            return response()->json([
                'success' => false,
                'message' => 'Ticket not found'
            ], 404);
        }

        return response()->json([
            'success' => true,
            'data' => $ticket
        ]);
    }
}
