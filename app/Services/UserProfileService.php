<?php

namespace App\Services;

use App\Jobs\UploadAvatarToImgbbJob;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Storage;

class UserProfileService
{
    public function queueAvatarUpload(int $userId, ?UploadedFile $avatar): void
    {
        if (!$avatar || !$avatar->isValid()) {
            return;
        }

        $stored = $avatar->store('tmp/avatars');
        UploadAvatarToImgbbJob::dispatch($userId, Storage::path($stored));
    }
}
