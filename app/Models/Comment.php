<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Comment extends Model
{
    use HasFactory;
    protected $table = 'comments';
    protected $fillable = [
        'userId',
        'parent_id',
        'comment',
        'userName',
        'userAvatar',
        'maHotel',
        'maBlog',
        'level',
        'time',
        'rating'
    ];
    public function replies()
{
    return $this->hasMany(Comment::class, 'parent_id')->orderBy('created_at', 'desc')->with('replies');
}
    public function parent()
    {
        return $this->belongsTo(Comment::class, 'parent_id')->with('replies');
    }
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function hotel()
    {
        return $this->belongsTo(Hotel::class, 'maHotel');
    }
}
