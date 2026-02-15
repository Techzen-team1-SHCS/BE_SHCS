<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\GeminiService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ChatController extends Controller
{
    public function stream(Request $request)
    {
        $question = $request->input('message');

        if (!$question) {
            return response()->json([
                'status' => 400,
                'message' => 'Thiếu câu hỏi'
            ], 400);
        }

        // 🏨 Lấy danh sách khách sạn
        $hotels = DB::table('hotels')
            ->leftJoin('images', function ($join) {
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
                DB::raw('COUNT(images.id) as image_count')
            )
            ->groupBy(
                'hotels.id',
                'hotels.name',
                'hotels.province',
                'hotels.price',
                'hotels.description',
                'hotels.hotel_class',
                'hotels.name_nearby_place',
                'hotels.amenities',
                'hotels.text'
            )
            ->orderBy('hotels.hotel_class', 'desc')
            ->orderBy('hotels.price', 'asc')
            ->limit(40)
            ->get()
            ->map(function ($hotel) {

                $amenities = null;

                if ($hotel->amenities) {
                    if (str_starts_with($hotel->amenities, '[')) {
                        $decoded = json_decode($hotel->amenities, true);
                        $amenities = is_array($decoded) ? implode(', ', $decoded) : $hotel->amenities;
                    } else {
                        $amenities = $hotel->amenities;
                    }
                }

                return [
                    'id' => $hotel->id,
                    'name' => $hotel->name,
                    'province' => $hotel->province,
                    'price' => number_format($hotel->price, 0, ',', '.') . ' VND',
                    'stars' => $hotel->hotel_class 
                        ? str_repeat('⭐', ceil($hotel->hotel_class / 10)) 
                        : '⭐⭐⭐',
                    'description' => $hotel->description ?: $hotel->text,
                    'amenities' => $amenities,
                ];
            })
            ->toArray();

        $hotelsJson = json_encode($hotels, JSON_UNESCAPED_UNICODE);

        // 🎯 PROMPT yêu cầu JSON
        $prompt = "
Bạn là AI tư vấn khách sạn.

Dữ liệu khách sạn (JSON):
$hotelsJson

Câu hỏi người dùng:
\"$question\"

Hãy lọc và trả về danh sách khách sạn phù hợp.

Trả về JSON array theo đúng format:
[
  {
    \"id\": number,
    \"name\": string,
    \"province\": string,
    \"price\": string,
    \"stars\": string,
    \"description\": string
  }
]

Chỉ trả về JSON. Không thêm text ngoài JSON.
";

        $gemini = new GeminiService();
        $aiResponse = $gemini->generateText($prompt);

        if (!$aiResponse) {
            return response()->json([
                'status' => 500,
                'message' => 'AI không phản hồi'
            ], 500);
        }

        // 🧹 Clean nếu AI thêm ```json
        $clean = trim($aiResponse);
        $clean = preg_replace('/^```json|```$/m', '', $clean);

        $decoded = json_decode($clean, true);

        if (!$decoded) {
            return response()->json([
                'status' => 500,
                'message' => 'AI trả JSON không hợp lệ',
                'raw' => $aiResponse
            ], 500);
        }

        return response()->json([
            'status' => 200,
            'hotels' => $decoded
        ]);
    }
}
