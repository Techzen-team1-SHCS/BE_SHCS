<?php

namespace App\Services;

use App\Jobs\UploadHotelImagesToCloudinaryJob;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Storage;

class HotelService
{
    public function queueImageUploads(int $hotelId, array $files): void
    {
        $paths = [];
        foreach ($files as $file) {
            if (!$file instanceof UploadedFile || !$file->isValid()) {
                continue;
            }
            $stored = $file->store('tmp/hotel-images');
            $paths[] = Storage::path($stored);
        }

        if ($paths !== []) {
            UploadHotelImagesToCloudinaryJob::dispatch($hotelId, $paths);
        }
    }

    public function invalidateHotelCaches(): void
    {
        Cache::forget('top_hotels');
        Cache::forget('destinations_count');
    }
}
