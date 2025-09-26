<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\PasswordResetRequest;
use App\Http\Requests\UpdateRequest;
use App\Http\Requests\UserRequest;
use App\Models\Image;
use App\Models\User;
use App\Services\UserServices;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use GuzzleHttp\Client;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Cloudinary\Uploader; // từ SDK, không phải Facade Laravel
use Illuminate\Support\Facades\DB;

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
   public function addUser(UserRequest $request)
    {
        $validated = $request->validated();

        // 1️⃣ Tạo user
        $user = User::create([
            'name'     => $validated['name'],
            'email'    => $validated['email'],
            'phone'    => $validated['phone'] ?? '',
            'password' => Hash::make($validated['password']),
        ]);

        // 2️⃣ Upload avatar lên ImgBB nếu có
        $avatarUrl = '';
        if ($request->hasFile('avatar') && $request->file('avatar')->isValid()) {
            $file = $request->file('avatar');
            $imgData = base64_encode(file_get_contents($file->getRealPath()));
            $apiKey = env('IMGBB_API_KEY');

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, 'https://api.imgbb.com/1/upload?key='.$apiKey);
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, ['image' => $imgData]);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

            $response = curl_exec($ch);
            curl_close($ch);

            $data = json_decode($response, true);
            $avatarUrl = $data['data']['url'] ?? '';
        }

        // 3️⃣ Lưu avatar vào bảng images
        if ($avatarUrl) {
            Image::create([
            'url' => $avatarUrl,
            'type' => 'avatar',
            'reference_id' => $user->id,
        ]);

                }

                return response()->json([
                    'status' => 'success',
                    'data' => $user,
                    'avatar_url' => $avatarUrl
                ], 201);
    }
    public function update(UpdateRequest $request, $id)
    {
        $validated = $request->validated();

        // 1️⃣ Tìm user
        $user = User::findOrFail($id);

        // 2️⃣ Cập nhật thông tin cơ bản
        $user->update([
            'name'     => $validated['name'] ?? $user->name,
            'email'    => $validated['email'] ?? $user->email,
            'phone'    => $validated['phone'] ?? $user->phone,
            'password' => !empty($validated['password']) ? Hash::make($validated['password']) : $user->password,
        ]);

        $avatarUrl = '';

        // 3️⃣ Upload avatar mới nếu có
        if ($request->hasFile('avatar') && $request->file('avatar')->isValid()) {
            $file = $request->file('avatar');
            $imgData = base64_encode(file_get_contents($file->getRealPath()));
            $apiKey = env('IMGBB_API_KEY');

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, 'https://api.imgbb.com/1/upload?key=' . $apiKey);
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, ['image' => $imgData]);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

            $response = curl_exec($ch);
            curl_close($ch);

            $data = json_decode($response, true);
            $avatarUrl = $data['data']['url'] ?? '';

            if ($avatarUrl) {
                // 🔄 Xoá avatar cũ (nếu có)
                Image::where('reference_id', $user->id)
                    ->where('type', 'avatar')
                    ->delete();

                // ➕ Lưu avatar mới
                Image::create([
                    'url'          => $avatarUrl,
                    'type'         => 'avatar',
                    'reference_id' => $user->id,
                ]);
            }
        }

        return response()->json([
            'status'     => 'success',
            'data'       => $user->fresh(),
            'avatar_url' => $avatarUrl ?: Image::where('reference_id', $user->id)->where('type', 'avatar')->value('url'),
        ], 200);
    }

}

