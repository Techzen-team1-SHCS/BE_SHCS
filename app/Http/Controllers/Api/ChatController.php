<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\GeminiService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ChatController extends Controller
{
    public function stream()
{
    $question = request('message');

    // 🏨 Lấy data với format tốt hơn
    $hotels = DB::table('hotels')
        ->leftJoin('images', function($join) {
            $join->on('hotels.id', '=', 'images.reference_id')
                 ->where('images.type', '=', 'hotel');
        })
        ->select(
            'hotels.id',
            'hotels.name',
            'hotels.province',
            'hotels.price',
            'hotels.description',
            'hotels.hotel_class',
            'hotels.name_nearby_place',
            'hotels.amenities',
            'hotels.text',
            DB::raw('COUNT(images.id) as image_count'),
            DB::raw('MAX(images.url) as sample_image')
        )
        ->groupBy('hotels.id', 'hotels.name', 'hotels.province', 'hotels.price',
                 'hotels.description', 'hotels.hotel_class', 'hotels.name_nearby_place',
                 'hotels.amenities', 'hotels.text')
        ->orderBy('hotels.hotel_class', 'desc')
        ->orderBy('hotels.price', 'asc')
        ->limit(40)
        ->get()
        ->map(function ($hotel) {
            // Format dữ liệu
            $data = [
                'id' => $hotel->id,
                'name' => $hotel->name,
                'province' => $hotel->province,
                'price' => number_format($hotel->price, 0, ',', '.') . ' VND',
                'stars' => $hotel->hotel_class ? str_repeat('⭐', ceil($hotel->hotel_class / 10)) : '⭐⭐⭐',
                'description' => $hotel->description ?: $hotel->text,
                'location_note' => $hotel->name_nearby_place,
                'has_images' => $hotel->image_count > 0,
            ];

            // Xử lý amenities
            if ($hotel->amenities) {
                if ($hotel->amenities[0] === '[') {
                    // JSON array
                    $amenities = json_decode($hotel->amenities, true);
                    $data['amenities'] = is_array($amenities) ? implode(', ', $amenities) : $hotel->amenities;
                } else {
                    $data['amenities'] = $hotel->amenities;
                }
            }

            return $data;
        })
        ->toArray();

    // 🎯 PROMPT NGẮN GỌN, TỐI ƯU
    $hotelsJson = json_encode($hotels, JSON_UNESCAPED_UNICODE | JSON_PRETTY_PRINT);

    $prompt = "Bạn là chatbot tư vấn khách sạn. Dưới đây là danh sách khách sạn thực tế:\n\n";
    $prompt .= $hotelsJson . "\n\n";
    $prompt .= "User hỏi: \"$question\"\n\n";
    $prompt .= "Hãy trả lời bằng tiếng Việt, markdown format. Chỉ đề xuất khách sạn có trong danh sách trên. Nếu không có thì nói không tìm thấy.";

    $gemini = new GeminiService();

    // 🔴 STREAMING
    return response()->stream(function () use ($gemini, $prompt) {
        $text = $gemini->generateText($prompt);

        // Stream từng đoạn nhỏ
        $chunks = str_split($text, 60);
        foreach ($chunks as $chunk) {
            if (trim($chunk)) {
                echo "data: " . $chunk . "\n\n";
                ob_flush();
                flush();
                usleep(30000); // 30ms
            }
        }
    }, 200, [
        'Content-Type' => 'text/event-stream',
        'Cache-Control' => 'no-cache',
        'X-Accel-Buffering' => 'no'
    ]);
}
}
