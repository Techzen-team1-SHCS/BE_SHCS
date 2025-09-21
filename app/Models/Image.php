<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Image extends Model
{
    protected $fillable = [
        'url', 'type', 'reference_id'
    ];

    // Nếu muốn, tạo quan hệ với User
    public function user()
    {
        return $this->belongsTo(User::class, 'reference_id');
    }

    // Quan hệ với Hotel (nếu có)
    
}
