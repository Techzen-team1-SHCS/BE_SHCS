<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Jobs\CreateUserBehaviorJob;

class UserBehaviorController extends Controller
{
    public function batch(Request $request)
    {
        try {
            $validator = Validator::make($request->all(), [
                'logs' => 'required|array',
                'logs.*.user_id' => 'nullable|exists:users,id',
                'logs.*.hotel_id' => 'nullable|exists:hotels,id',
                'logs.*.action' => 'required|string|max:191',
                'logs.*.metadata' => 'nullable|array',
            ]);

            if ($validator->fails()) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Validation failed',
                    'errors' => $validator->errors()
                ], 422);
            }

            $logs = $request->input('logs');
            $authUserId = auth()->id(); // lấy user_id từ token (nếu có)

            foreach ($logs as $log) {
                // Nếu không có user_id trong log thì gán user từ token
                if (empty($log['user_id']) && $authUserId) {
                    $log['user_id'] = $authUserId;
                }

                CreateUserBehaviorJob::dispatch($log);
            }

            return response()->json([
                'status' => 'success',
                'message' => count($logs).' logs dispatched to queue',
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

}
