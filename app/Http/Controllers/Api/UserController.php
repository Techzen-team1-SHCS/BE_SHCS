<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\PasswordResetRequest;
use App\Http\Requests\UserRequest;
use App\Models\User;
use App\Services\UserServices;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
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

    public function login(LoginRequest $request) ///
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
   public function logout(Request $request)
   {
    $user = $request->user();

    if (!$user) {
        return response()->json(['message' => 'Token không hợp lệ hoặc chưa đăng nhập'], 401);
    }

    // Thu hồi token hiện tại
    $user->token()->revoke();

    return response()->json(['message' => 'Đăng xuất thành công']);
    }
    public function passwordRetrieval(PasswordResetRequest $request)
    {
        $this->user->resetPassword($request->email);
        return response()->json(['status' => 200, 'message' => 'New password sent to email']);
    }
    public function loginGoogle(Request $request)
{
    try {
        $request->validate([
            'id_token' => 'required|string',
        ]);

        $client = new Client();

        $response = $client->get('https://oauth2.googleapis.com/tokeninfo', [
            'query' => ['id_token' => $request->id_token],
        ]);

        $googleUser = json_decode($response->getBody(), true);

        // Debug log


    if (!isset($googleUser['email_verified']) || $googleUser['email_verified'] !== 'true') {
        return response()->json([
            'status' => false,
            'message' => 'Email chưa xác thực'
        ], 403);
    }

    $email = $googleUser['email'];
    $name = $googleUser['name'] ?? explode('@', $email)[0];
    $avatar = $googleUser['picture'] ?? null;

    $user = User::firstOrCreate(
        ['email' => $email],
        [
            'name' => $name,
            'avatar' => $avatar,
            'password' => bcrypt(Str::random(16))
        ]
    );

    $token = $user->createToken('GoogleToken')->accessToken;

        return response()->json([
            'status' => true,
            'token' => $token,
            'user' => $user,
        ]);
    } catch (\Exception $e) {
        return response()->json([
            'status' => false,
            'message' => 'Lỗi đăng nhập Google: ' . $e->getMessage()
        ], 500);
    }
}
    public function UpdateProfile(){
        
    }
}
