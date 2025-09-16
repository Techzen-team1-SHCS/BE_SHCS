<?php

namespace App\Services;

use App\Repositories\UserRepositories;
use Illuminate\Support\Facades\Hash;

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

}
