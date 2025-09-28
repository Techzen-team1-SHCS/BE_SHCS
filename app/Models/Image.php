<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Image extends Model
{   
    protected $table='images';
    protected $fillable = [
        'url', 'type', 'reference_id'
    ];

    // Nếu muốn, tạo quan hệ với User
    public function user()
    {
        return $this->belongsTo(User::class, 'reference_id');
    }
     public function imageable()
    {
        return $this->morphTo(__FUNCTION__, 'type', 'reference_id');
    }
}
