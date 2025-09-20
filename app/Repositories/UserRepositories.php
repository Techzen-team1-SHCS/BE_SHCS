<?php
namespace App\Repositories;
use App\Models\User;
class UserRepositories{
   protected $model;
   public function __construct(User $model)
   {
       $this->model=$model;
   }
   public function create(array $data){
       return $this->model->create($data);
   }
   public function findByEmail(string $email)
   {
       return $this->model->where('email',$email)->first();
   }
   public function updatePassword($model,string $hashedPassword)
   {
       $model->password=$hashedPassword;
       $model->save();
       return $model;
   }
   public function update(User $user,array $data)
   {
    return  $user->update($data);
   }
}
