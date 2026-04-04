<?php

namespace App\Jobs;

use App\Models\Image;
use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class UploadAvatarToImgbbJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public int $timeout = 120;
    public int $tries = 3;

    public function __construct(
        private readonly int $userId,
        private readonly string $localFilePath
    ) {
    }

    public function handle(): void
    {
        $user = User::find($this->userId);
        if (!$user || !is_file($this->localFilePath)) {
            return;
        }

        $apiKey = env('IMGBB_API_KEY');
        if (!$apiKey) {
            Log::warning('IMGBB_API_KEY is missing');
            return;
        }

        $imgData = base64_encode((string) file_get_contents($this->localFilePath));

        $response = Http::asForm()
            ->timeout(10)
            ->retry(2, 200)
            ->post('https://api.imgbb.com/1/upload', [
                'key' => $apiKey,
                'image' => $imgData,
            ]);

        if (!$response->successful()) {
            Log::error('ImgBB upload failed', ['body' => $response->body()]);
            return;
        }

        $avatarUrl = data_get($response->json(), 'data.url');
        if (!$avatarUrl) {
            return;
        }

        $user->image = $avatarUrl;
        $user->save();

        Image::updateOrCreate(
            ['type' => 'avatar', 'reference_id' => $user->id],
            ['url' => $avatarUrl]
        );

        @unlink($this->localFilePath);
    }
}
