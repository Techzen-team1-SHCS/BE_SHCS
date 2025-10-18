<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Illuminate\Validation\ValidationException;
use Illuminate\Database\Eloquent\ModelNotFoundException;
use Illuminate\Database\QueryException;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpKernel\Exception\NotFoundHttpException;
use Throwable;

class Handler extends ExceptionHandler
{
    protected $levels = [];

    protected $dontReport = [];

    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    public function register(): void
    {
        $this->reportable(function (Throwable $e) {
            //
        });
    }

    public function render($request, Throwable $exception)
    {
        // 🔹 Validation lỗi
        if ($exception instanceof ValidationException) {
            return response()->json([
                'status' => false,
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $exception->errors(),
            ], 422);
        }

        // 🔹 Không đăng nhập
        if ($exception instanceof AuthenticationException) {
            return response()->json([
                'status' => false,
                'message' => 'Bạn chưa đăng nhập hoặc phiên đăng nhập đã hết hạn',
            ], 401);
        }

        // 🔹 Không tìm thấy model
        if ($exception instanceof ModelNotFoundException) {
            return response()->json([
                'status' => false,
                'message' => 'Không tìm thấy dữ liệu yêu cầu',
            ], 404);
        }

        // 🔹 Route không tồn tại
        if ($exception instanceof NotFoundHttpException) {
            return response()->json([
                'status' => false,
                'message' => 'Đường dẫn không tồn tại',
            ], 404);
        }

        // 🔹 Lỗi truy vấn DB
        if ($exception instanceof QueryException) {
            Log::error('Lỗi DB: ' . $exception->getMessage());
            return response()->json([
                'status' => false,
                'message' => 'Lỗi cơ sở dữ liệu, vui lòng thử lại sau.',
            ], 500);
        }

        // 🔹 Các lỗi khác (catch-all)
        Log::error('Lỗi hệ thống: ' . $exception->getMessage(), [
            'file' => $exception->getFile(),
            'line' => $exception->getLine(),
        ]);

        // Nếu là môi trường local → show lỗi chi tiết cho dev
        if (config('app.debug')) {
            return parent::render($request, $exception);
        }

        // Nếu là production → ẩn thông tin lỗi
        return response()->json([
            'status' => false,
            'message' => 'Lỗi hệ thống, vui lòng thử lại sau.',
        ], 500);
    }
}
