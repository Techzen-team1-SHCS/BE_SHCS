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

        // 🎯 PROMPT yêu cầu JSON chứa cả câu trả lời và danh sách
        $prompt = "
Bạn là chuyên viên tư vấn khách sạn lịch sự, thân thiện và chuyên nghiệp.

Dữ liệu hệ thống khách sạn hiện có:
$hotelsJson

Câu hỏi của khách hàng:
\"$question\"

Quy tắc bắt buộc:
1. Bạn BẮT BUỘC phải phân tích câu hỏi. Nếu thông tin quá chung chung (chưa rõ Tỉnh thành/nơi đến muốn đặt), bạn PHẢI TỰ ĐỘNG hỏi lại để xin thêm thông tin. (Ví dụ: 'Dạ để tìm khách sạn phù hợp cho người lớn tuổi, cho em hỏi mình định đi du lịch ở tỉnh thành nào vậy ạ?').
2. KỂ CẢ KHI BẠN HỎI LẠI, kết quả trả về cũng phải luôn luôn nằm trong định dạng mã code JSON bên dưới. KHÔNG BAO GIỜ trả lời text tự do ra bên ngoài.
3. KHÔNG sử dụng ký tự bọc markdown như ```json. Chỉ trả về một Object duy nhất.

Cấu trúc JSON yêu cầu:
{
  \"reply\": \"(Nhập câu trò chuyện tư vấn viên hoặc câu hỏi xin thêm thông tin tại đây)\",
  \"hotels\": [
    {
      \"id\": number,
      \"name\": string,
      \"province\": string,
      \"price\": string,
      \"stars\": string,
      \"description\": string
    }
  ]
}
Lưu ý: Nếu đang hỏi ngược lại người dùng để lấy thêm thông tin, mảng 'hotels' sẽ là mảng rỗng [].
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
            $isOverloaded = str_contains(strtolower($aiResponse), '503') || str_contains(strtolower($aiResponse), 'high demand');
            if ($isOverloaded) {
                 return response()->json([
                     'status' => 200,
                     'reply' => '🤖 Hệ thống AI hiện đang xử lý quá nhiều yêu cầu. Bạn vui lòng đợi vài giây rồi thử lại nhé!',
                     'hotels' => []
                 ]);
            }
            return response()->json([
                'status' => 500,
                'message' => 'AI trả JSON không hợp lệ / Lỗi kết nối AI',
                'raw' => $aiResponse
            ], 500);
        }

        return response()->json([
            'status' => 200,
            'reply' => $decoded['reply'] ?? '',
            'hotels' => $decoded['hotels'] ?? []
        ]);
    }
}
