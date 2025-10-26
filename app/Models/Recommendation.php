<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Recommendation extends Model
{
    use HasFactory;
    protected $table='recommendations';
    protected $fillable=[
        'user_id',
        'data'
    ];
    protected $casts=[
        'data'=>'array',
    ];
    public function owner(){
        return $this->belongsTo(User::class,'user_id');
    }
}
