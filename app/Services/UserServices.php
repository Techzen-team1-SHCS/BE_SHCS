<?php

namespace App\Services;

use App\Mail\MailPassword;
use App\Models\User;
use App\Repositories\UserRepositories;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Error;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;
class UserServices{
    protected $user;
    public function __construct(UserRepositories $user)
    {
       $this->user=$user;
    }
    public function signup(array $data){
        $data['password']=Hash::make($data['password']);
        $data['role']=$data['role'] ?? 0;

        return $this->user->create($data);
    }
    public function login(array $data){
        $user=$this->user->findByEmail($data['email']);
        if(!$user || !Hash::check($data['password'],$user->password)){
         return false;
        }
        if ($user->is_blocked) {
            return response()->json(['message' => 'Tài khoản của bạn đã bị chặn!'], 403);
        }
        $tokenResult = $user->createToken('Personal Access Token');
        $accessToken = $tokenResult->accessToken;
        $token = $tokenResult->token;

        return [
            'user' => $user,
            'access_token' => $accessToken,
            'token_type' => 'Bearer',
            'expires_at' => $token->expires_at,
        ];

    }
    public function resetPassword(string $email){
        $user=$this->user->findByEmail($email);
        if(!$user){
            throw new Error();
        }
        $newPassword=Str::random(6);
        $this->user->updatePassword($user,Hash::make($newPassword));
        Mail::to($email)->send(new MailPassword($newPassword));
        return $newPassword;
    }


    public function updateProfile($id, array $data)
{
    $user = $this->user->find($id);

    if (!$user) {
        throw new \Exception("User not found");
    }

    // Xử lý avatar nếu có
    if (!empty($data['avatar']) && $data['avatar']->isValid()) {
        // Xóa avatar cũ nếu có public_id
        if (!empty($user->avatar_public_id)) {
            Cloudinary::destroy($user->avatar_public_id);
        }

        // Upload avatar mới lên Cloudinary
        $uploaded = Cloudinary::upload(
            $data['avatar']->getRealPath(),
            ['folder' => "avatars/{$user->id}"]
        );

        $data['avatar'] = $uploaded->getSecurePath();
        $data['avatar_public_id'] = $uploaded->getPublicId();
    } else {
        // Nếu không có file avatar mới thì loại bỏ key để không update
        unset($data['avatar']);
        unset($data['avatar_public_id']);
    }

    // Update tất cả dữ liệu còn lại (name, phone, avatar)
    if (!empty($data)) {
        $this->user->update($user, $data);
    }

    return $user->fresh(); // Refresh model để lấy dữ liệu mới
}






}
