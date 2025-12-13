<?php

namespace App\Console\Commands;

use App\Models\Recommendation;
use App\Models\UserBehavior;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class SendBehaviorToAI extends Command
{
    protected $signature = 'ai:send-behaviors';
    protected $description = 'Gửi batch user behaviors sang Python AI server để phân tích';

    public function handle()
    {
        // 1. Lấy batch hành vi mới nhất
        $behaviors = UserBehavior::where('is_sent', true)
        ->orderByDesc('timestamp')
        ->take(100)
        ->get();
        if ($behaviors->isEmpty()) {
            $this->info('Không có dữ liệu để gửi.');
            return;
        }

        // 2. Chuẩn bị dữ liệu đúng format API yêu cầu
        $payload = $behaviors->map(function ($behavior) {
            return [
                'user_id'    => $behavior->user_id,
                'item_id'    => $behavior->hotel_id,
                'action_type'=> $behavior->action,   // click | like | share | booking
                'timestamp' => (float) strtotime($behavior->timestamp),
            ];
        })->values()->toArray();
        try {
            // Nếu API_KEY được cấu hình, thêm header Authorization
            $headers = [];
            $apiKey = config('services.recbole.api_key'); // ví dụ lấy từ config
            if (!empty($apiKey)) {
                $headers['Authorization'] = 'Bearer ' . $apiKey;
            }

            // 3. Gửi batch hành vi sang AI (POST /user_actions_batch)
            $response = Http::timeout(10)
                ->withHeaders($headers)
                ->post('http://192.168.30.110:5000/user_actions_batch', $payload);

            if (!$response->successful()) {
                $this->error('Gửi user_actions_batch thất bại: ' . $response->body());
                Log::error('AI server trả lỗi khi nhận hành vi', ['status' => $response->status(), 'body' => $response->body()]);
                return;
            }

            $this->info('Đã gửi hành vi thành công.');

            // 4. Với mỗi user trong batch, gọi API lấy recommendations và lưu
            $uniqueUserIds = $behaviors->pluck('user_id')->unique();

            foreach ($uniqueUserIds as $userId) {
                $recommendationRes = Http::timeout(10)
                    ->withHeaders($headers)
                    ->get("http://192.168.30.110:5000/recommendations/{$userId}", [
                        'top_k' => 10,
                    ]);
                if (!$recommendationRes->successful()) {
                    $this->warn("Không lấy được recommendation cho user {$userId}: " . $recommendationRes->body());
                    Log::warning('Lỗi lấy recommendation', ['user_id' => $userId, 'status' => $recommendationRes->status(), 'body' => $recommendationRes->body()]);
                    continue;
                }

                $data = $recommendationRes->json();
                Recommendation::updateOrCreate(
                    ['user_id' => $userId],
                    [
                        'data'          => json_encode($data['recommendations'] ?? []),
                        'model_version' => $data['model_version'] ?? null,
                        'top_k'         => $data['top_k'] ?? 0,
                    ]
                );
                UserBehavior::where('user_id', $userId)->delete();
            }

            Log::info('AI recommendations saved successfully.');
            $this->info('Đã lưu gợi ý từ AI.');
        } catch (\Throwable $e) {
            Log::error('Lỗi khi gửi dữ liệu sang AI', ['exception' => $e]);
            $this->error('Lỗi khi gọi AI: ' . $e->getMessage());
        }
    }
}
