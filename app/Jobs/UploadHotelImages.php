<?php

namespace App\Jobs;

use App\Models\Image;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class UploadHotelImages implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $hotelId;
    protected $encodedImages;

    /**
     * Create a new job instance.
     *
     * @param int $hotelId
     * @param array $encodedImages
     */
    public function __construct(int $hotelId, array $encodedImages)
    {
        $this->hotelId = $hotelId;
        $this->encodedImages = $encodedImages;
    }

    /**
     * Execute the job.
     */
    public function handle()
    {
        Log::info('UploadHotelImages started', [
            'hotel_id' => $this->hotelId,
            'count' => count($this->encodedImages),
        ]);

        foreach ($this->encodedImages as $index => $imgData) {
            try {
                $apiKey = env('IMGBB_API_KEY');
                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, 'https://api.imgbb.com/1/upload?key=' . $apiKey);
                curl_setopt($ch, CURLOPT_POST, 1);
                curl_setopt($ch, CURLOPT_POSTFIELDS, ['image' => $imgData]);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_TIMEOUT, 120); // tăng timeout
                $response = curl_exec($ch);
                $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
                $curlErr = curl_error($ch);
                curl_close($ch);

                if ($response === false) {
                    Log::error('ImgBB CURL error', ['err' => $curlErr, 'hotel_id' => $this->hotelId]);
                    continue;
                }

                $data = json_decode($response, true);
                $imageUrl = $data['data']['display_url'] ?? $data['data']['url'] ?? null;

                if ($httpCode === 200 && $imageUrl) {
                    Image::create([
                        'url' => $imageUrl,
                        'type' => 'hotel',
                        'reference_id' => $this->hotelId,
                    ]);
                    Log::info('ImgBB upload success', [
                        'hotel_id' => $this->hotelId,
                        'image_index' => $index,
                        'url' => $imageUrl,
                    ]);
                } else {
                    Log::error('ImgBB upload failed', [
                        'hotel_id' => $this->hotelId,
                        'image_index' => $index,
                        'http_code' => $httpCode,
                        'response' => $data ?? $response,
                    ]);
                }
            } catch (\Throwable $e) {
                Log::error('UploadHotelImages exception', [
                    'hotel_id' => $this->hotelId,
                    'image_index' => $index,
                    'msg' => $e->getMessage(),
                ]);
            }
        }

        Log::info('UploadHotelImages finished', ['hotel_id' => $this->hotelId]);
    }
}
