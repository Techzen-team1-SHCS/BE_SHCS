<?php

namespace App\Services;

use App\Mail\MailPassword;
use App\Models\User;
use App\Repositories\UserRepositories;
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
    public function updateProfile($id,array $data)
    {
        $user=User::FindOrFail($id);
        if(isset($data['image']) && $data['image']->isValid()){
            $file=$data['image'];
            $imageDirectory='images/User/';
        }
    }

}
