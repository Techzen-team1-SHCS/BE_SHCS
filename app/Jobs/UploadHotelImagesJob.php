<?php

namespace App\Jobs;

use App\Models\Image as ModelsImage;
use CloudinaryLabs\CloudinaryLaravel\Facades\Cloudinary;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Intervention\Image\ImageManagerStatic as Image;

class UploadHotelImagesJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $hotel;
    protected $files;

    /**
     * Create a new job instance.
     */
    public function __construct($hotel, $files)
    {
        $this->hotel = $hotel;
        $this->files = $files;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        foreach ($this->files as $file) {
            // Nếu là UploadedFile, lấy path
            $path = is_string($file) ? $file : $file->getRealPath();

            // Resize + convert WebP + nén
            $img = Image::make($path)
                ->resize(1080, null, function($constraint){
                    $constraint->aspectRatio();
                    $constraint->upsize();
                })
                ->encode('webp', 80);

            // Upload lên Cloudinary
            $uploadedFile = Cloudinary::uploadFile($img->stream()->__toString(), [
                'folder' => 'hotels/' . $this->hotel->id,
                'format' => 'webp',
                'transformation' => [
                    'quality' => 'auto',
                    'fetch_format' => 'webp'
                ],
            ]);

            // Lưu URL vào DB
            ModelsImage::create([
                'url' => $uploadedFile->getSecurePath(),
                'reference_id' => $this->hotel->id,
                'type' => 'hotel'
            ]);
        }
    }
}
