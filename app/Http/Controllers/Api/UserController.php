<?php

namespace App\Http\Controllers\Api;

use App\Helpers\NotificationHelper;
use App\Http\Controllers\Controller;
use App\Http\Requests\LoginRequest;
use App\Http\Requests\PasswordResetRequest;
use App\Http\Requests\UpdateRequest;
use App\Http\Requests\UserRequest;
use App\Mail\RegisterEmail;
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
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Password;

class UserController extends Controller
{
    protected $user;
    public function __construct(UserServices $user)
    {
        $this->user=$user;
    }
    public function register(UserRequest $request)
    {
        $validated = $request->validated();

        // 1️⃣ Tạo user (Thao tác DB nhanh, < 0.1s)
        $user = User::create([
            'name'     => $validated['name'],
            'email'    => $validated['email'],
            'phone'    => $validated['phone'] ?? '',
            'password' => Hash::make($validated['password']),
            'role'     => $validated['role'] ?? 0,
        ]);

        // 2️⃣ Xử lý Avatar (Tách ra hàm riêng cho sạch Controller)
        $avatarUrl = $this->handleAvatarUpload($request, $user->id);

        // 3️⃣ Gửi Email VÀO HÀNG ĐỢI (Chạy ngầm - Không bắt user đợi)
        // 🚨 QUAN TRỌNG: Thay send() bằng queue()
        Mail::to($user->email)->queue(new RegisterEmail($user));

        // 4️⃣ Gửi thông báo in-app
        NotificationHelper::send(
            $user->id,
            'Registration_Successful',
            'Đăng ký thành công',
            "Chào mừng {$user->name} đã đăng ký thành công tài khoản."
        );

        // 5️⃣ Trả về Response ngay lập tức
        return response()->json([
            'status'     => 'success',
            'data'       => $user,
            'avatar_url' => $avatarUrl
        ], 201);
    }

    /**
     * Hàm private xử lý riêng việc upload ảnh lên ImgBB
     */
    private function handleAvatarUpload($request, $userId)
    {
        if (!$request->hasFile('avatar') || !$request->file('avatar')->isValid()) {
            return '';
        }

        try {
            $file = $request->file('avatar');
            $imgData = base64_encode(file_get_contents($file->getRealPath()));
            $apiKey = env('IMGBB_API_KEY');

            $ch = curl_init();
            curl_setopt($ch, CURLOPT_URL, 'https://api.imgbb.com/1/upload?key=' . $apiKey);
            curl_setopt($ch, CURLOPT_POST, 1);
            curl_setopt($ch, CURLOPT_POSTFIELDS, ['image' => $imgData]);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_TIMEOUT, 5); // Set timeout tối đa 5s để tránh treo server

            $response = curl_exec($ch);
            curl_close($ch);

            $data = json_decode($response, true);
            $avatarUrl = $data['data']['url'] ?? '';

            if ($avatarUrl) {
                Image::create([
                    'url'          => $avatarUrl,
                    'type'         => 'avatar',
                    'reference_id' => $userId,
                ]);
            }

            return $avatarUrl;

        } catch (\Exception $e) {
            // Log lỗi nếu ImgBB sập, không làm chết luồng đăng ký của user
            \Log::error('ImgBB Upload Error: ' . $e->getMessage());
            return '';
        }
    }
    public function index()
    {
        try {
            $users=User::all();
            if ($users->isEmpty()) {
                return response()->json([
                    'status' => 200,
                    'message' => 'Không có người dùng nào',
                    'users' => []
                ], 200);
        }
            return response()->json([
                'status'=>200,
                'data'=>$users
            ],200);
        } catch (\Throwable $th) {
            return response()->json([
                'status'=>404,
                'error'=>'Đã xảy ra lỗi khi lấy dữ liệu người dùng'
            ],500);
        }

    }
    public function show($id)
{
    try {

        $user = User::findOrFail($id);
        return response()->json([
            'status' => 200,
            'data' => $user
        ], 200);

    } catch (\Illuminate\Database\Eloquent\ModelNotFoundException $e) {
        return response()->json([
            'status' => 404,
            'error'  => 'Người dùng không tồn tại'
        ], 404);

    } catch (\Exception $e) {
        return response()->json([
            'status' => 500,
            'error'  => 'Đã xảy ra lỗi hệ thống',
            'message' => $e->getMessage() // ⚠️ để debug tạm (bạn có thể xóa khi deploy)
        ], 500);
    }
}


    public function login(LoginRequest $request)
    {
        $result = $this->user->login($request->validated());

        if ($result === 'invalid') {
            return response()->json([
                'status' => 401,
                'message' => 'Sai tài khoản hoặc mật khẩu'
            ], 401);
        }

        if ($result === 'blocked') {
            return response()->json([
                'status' => 403,
                'message' => 'Tài khoản của bạn đã bị chặn!'
            ], 403);
        }

        return response()->json([
            'status' => 200,
            'message' => 'Đăng nhập thành công!',
            'data' => $result
        ], 200);
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
    public function update(Request $request, $id)
    {
        // 1️⃣ Validate dữ liệu
        $validated = $request->validate([
            'name'     => 'nullable|string|max:255',
            'email'    => 'nullable|email|max:255|unique:users,email,' . $id,
            'phone'    => 'nullable|string|max:20',
            'password' => 'nullable|string|min:6',
            'gender'   => 'nullable|string|min:3',
            'birth'    => 'nullable|date',
            'address'  => 'nullable|string|max:255',
            'avatar'   => 'nullable|image|max:5120', // 5MB
        ]);

        // 2️⃣ Tìm user
        $user = User::findOrFail($id);

        // 3️⃣ Cập nhật thông tin cơ bản
        $user->update([
            'name'     => $validated['name'] ?? $user->name,
            'email'    => $validated['email'] ?? $user->email,
            'phone'    => $validated['phone'] ?? $user->phone,
            'password' => !empty($validated['password']) ? Hash::make($validated['password']) : $user->password,
            'gender'   => $validated['gender'] ?? $user->gender,
            'birth'    => $validated['birth'] ?? $user->birth,
            'address'  => $validated['address'] ?? $user->address
        ]);

        // 4️⃣ Upload avatar nếu có
        if ($request->hasFile('avatar') && $request->file('avatar')->isValid()) {
            try {
                $file = $request->file('avatar');

                // Chuyển ảnh sang base64
                $imgData = base64_encode(file_get_contents($file->getRealPath()));
                $apiKey = env('IMGBB_API_KEY');

                // Gọi API ImgBB
                $ch = curl_init();
                curl_setopt_array($ch, [
                    CURLOPT_URL => 'https://api.imgbb.com/1/upload?key=' . $apiKey,
                    CURLOPT_POST => 1,
                    CURLOPT_POSTFIELDS => ['image' => $imgData],
                    CURLOPT_RETURNTRANSFER => true,
                ]);
                $response = curl_exec($ch);

                if (curl_errno($ch)) {
                    Log::error('ImgBB cURL error: ' . curl_error($ch));
                    return response()->json(['error' => 'Lỗi khi upload ảnh lên ImgBB'], 500);
                }

                curl_close($ch);

                $data = json_decode($response, true);
                $avatarUrl = $data['data']['url'] ?? null;

                if (!$avatarUrl) {
                    Log::error('ImgBB upload failed. Response: ' . $response);
                    return response()->json(['error' => 'Upload avatar thất bại'], 500);
                }

                // 5️⃣ Lưu thẳng URL vào cột image của user
                $user->image = $avatarUrl;
                $user->save();

            } catch (\Exception $e) {
                Log::error('Lỗi upload avatar: ' . $e->getMessage());
                return response()->json(['error' => 'Đã xảy ra lỗi khi cập nhật avatar'], 500);
            }
        }

        // 6️⃣ Trả về kết quả JSON
        return response()->json([
        'status'     => 'success',
        'message'    => 'Cập nhật thông tin thành công',
        'user'       => [
            'id'          => $user->id,
            'name'        => $user->name,
            'email'       => $user->email,
            'phone'       => $user->phone,
            'role'        => $user->role,
            'gender'      => $user->gender,
            'birth'       => $user->birth,
            'address'    => $user->address,
            'avatar_url'  => $user->image, // hoặc lấy từ bảng images nếu cần
            'created_at'  => $user->created_at,
            'updated_at'  => $user->updated_at,
        ]
], 200);
    }

    public function uploadAvatar(Request $request, $id)
    {
        $validated = $request->validate([
            'avatar' => 'required|image|max:5120',
        ]);

        $user = User::findOrFail($id);

        if ($request->hasFile('avatar') && $request->file('avatar')->isValid()) {
            try {
                $file = $request->file('avatar');
                $imgData = base64_encode(file_get_contents($file->getRealPath()));
                $apiKey = env('IMGBB_API_KEY');

                // Dùng Laravel Http client
                $response = Http::asForm()->post('https://api.imgbb.com/1/upload', [
                    'key' => $apiKey,
                    'image' => $imgData,
                ]);

                if (! $response->successful()) {
                    Log::error('ImgBB upload failed: ' . $response->body());
                    return response()->json(['error' => 'Upload avatar thất bại'], 500);
                }

                $data = $response->json();
                $avatarUrl = $data['data']['url'] ?? null;

                if (! $avatarUrl) {
                    Log::error('ImgBB response invalid: ' . $response->body());
                    return response()->json(['error' => 'Upload avatar thất bại'], 500);
                }

                // Lưu trực tiếp vào cột image
                $user->image = $avatarUrl;
                $user->save();

                return response()->json([
                    'status' => 'success',
                    'message' => 'Upload avatar thành công',
                    'avatar_url' => $avatarUrl,
                    'user' => $user->fresh(),
                ], 200);

            } catch (\Exception $e) {
                Log::error('Lỗi upload avatar: ' . $e->getMessage());
                return response()->json(['error' => 'Đã xảy ra lỗi khi upload avatar'], 500);
            }
        }
    }

    public function destroy($id)
    {
        try {
            $user=User::findOrFail($id);
            $user->delete();
            return response()->json([
                'status'=>200,
                'message'=>'Xóa người dùng thành công'
            ]);

        } catch (\Throwable $th) {
            return response()->json([
                'status'=>500,
                'error'=>'Không thể xóa người dùng'
            ],500);
        }

    }
     public function sendResetLink(Request $request)
    {

        $request->validate(['email' => 'required|email']);

        $user = User::where('email', $request->email)->first();

        if (!$user) {
            return response()->json([
                'status' => 404,
                'error' => 'Không tìm thấy người dùng với email này.'
            ]);
        }

        // 🟢 Tạo token thủ công
        $token = Password::createToken($user);

        // 🟢 Gửi Notification chứa token thật (chưa hash)
        $user->notify(new \App\Notifications\CustomResetPassword($token));

        return response()->json([
            'status' => 200,
            'message' => 'Link khôi phục mật khẩu đã được gửi đến email của bạn!'
        ]);
    }
    public function reset(Request $request)
    {
        $request->validate([
            'token' => 'required',
            'email' => 'required|email',
            'password' => 'required|min:6|confirmed',
        ]);

        $status = Password::reset(
            $request->only('email', 'password', 'password_confirmation', 'token'),
            function ($user, $password) {
                $user->forceFill(['password' => Hash::make($password)])->save();
            }
        );

        return $status === Password::PASSWORD_RESET
            ? response()->json(['status' => 200, 'message' => 'Mật khẩu đã được đặt lại thành công!'])
            : response()->json(['status' => 400, 'error' => __($status)]);
    }
}

