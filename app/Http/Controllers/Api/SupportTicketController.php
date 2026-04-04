<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Jobs\SendSupportTicketEmailsJob;
use App\Models\SupportTicket;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

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

        SendSupportTicketEmailsJob::dispatch($ticket->id);

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
        $tickets = SupportTicket::orderBy('created_at', 'desc')
            ->paginate((int) request('per_page', 20));

        return response()->json([
            'success' => true,
            'data' => $tickets->items(),
            'pagination' => [
                'current_page' => $tickets->currentPage(),
                'last_page' => $tickets->lastPage(),
                'per_page' => $tickets->perPage(),
                'total' => $tickets->total(),
            ],
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
