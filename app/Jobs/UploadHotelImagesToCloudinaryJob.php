<?php

namespace App\Jobs;

use App\Models\Image;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class UploadHotelImagesToCloudinaryJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $timeout = 180;
    public int $tries = 3;

    public function __construct(
        private readonly int $hotelId,
        private readonly array $localFilePaths
    ) {
    }

    public function handle(): void
    {
        foreach ($this->localFilePaths as $path) {
            if (!is_file($path)) {
                continue;
            }

            $uploadedFile = Cloudinary::uploadFile($path, [
                'folder' => 'hotels/' . $this->hotelId,
                'format' => 'webp',
                'transformation' => [
                    'quality' => 'auto',
                    'fetch_format' => 'webp',
                ],
            ]);

            Image::create([
                'url' => $uploadedFile->getSecurePath(),
                'reference_id' => $this->hotelId,
                'type' => 'hotel',
            ]);

            @unlink($path);
        }
    }
}
