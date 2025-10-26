<?php

namespace App\Console\Commands;

use App\Models\Recommendation;
use App\Models\UserBehavior;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class SendBehaviorToAI extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'ai:send-behaviors';
    /**
     * The console command description.
     *
     * @var string
     */
    protected $description='Gửi batch user behaviors sang Python AI server để phân tích';
    /**
     * Execute the console command.
     */
     public function handle()
    {
       $behaviors = UserBehavior::orderBy('timestamp', 'desc')->take(100)->get(); // lấy batch mới nhất

        if ($behaviors->isEmpty()) {
            $this->info("Không có dữ liệu để gửi.");
            return;
        }

        try {
            $response = Http::timeout(10)->post('http://127.0.0.1:5000/analyze', [
                'logs' => $behaviors,
            ]);

            if ($response->successful()) {
                $result = $response->json();
                foreach ($result['recommendations'] as $rec) {
                    Recommendation::updateOrCreate(
                        ['user_id' => $rec['user_id']],
                        ['data' => json_encode($rec['data'])]
                    );
                }

                Log::info("AI recommendations saved successfully.");
                $this->info("Đã gửi thành công & lưu kết quả gợi ý.");
            } else {
                Log::error("AI server không phản hồi hợp lệ.");
            }

        } catch (\Exception $e) {
            Log::error("Lỗi khi gửi dữ liệu sang AI: ".$e->getMessage());
        }
    }
}
