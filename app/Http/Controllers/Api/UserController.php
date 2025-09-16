<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\UserRequest;
use App\Services\UserServices;
use Illuminate\Http\Request;

class UserController extends Controller
{
    protected $user;
    public function __construct(UserServices $user)
    {
        $this->user=$user;
    }
      public function register(UserRequest $request)
    {
        // $request->validated() đã validate xong
        $data = $request->validated();

        try {
            $user = $this->user->signup($data);

            return response()->json([
                'status' => 201,
                'message' => 'Tạo tài khoản thành công',
                'user' => $user
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'status' => 500,
                'message' => 'Có lỗi xảy ra khi tạo tài khoản',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function login(LoginRequest $request)
    {
        $result = $this->user->login($request->validated());

        if (!$result) {
            return response()->json([
                'status' => 401,
                'error'  => 'Invalid credentials'
            ], 401);
        }

        return response()->json([
            'status' => 200,
            'message' => 'Login successful',
            'data' => $result
        ]);
    }

}
