<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;

class HM_AuthController extends Controller
{
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|min:8|confirmed',
            'phone' => 'nullable|string|max:20',
            'business_license_url' => 'required|url'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Dữ liệu không hợp lệ',
                'errors' => $validator->errors()
            ], 422);
        }

        $apiKey = env('OCR_SPACE_API_KEY');
        $imgUrl = $request->input('business_license_url');

        // Use POST instead of GET for better stability and parameter handling
        $response = Http::timeout(60)->asForm()->post('https://api.ocr.space/parse/image', [
            'apikey' => $apiKey,
            'url' => $imgUrl,
            'language' => 'eng',
            'OCREngine' => 1
        ]);

        if($response->successful()) {
            $data = $response->json();
            
            // Log raw response for debugging before checking errors
            Log::info("OCR Raw Data for " . $request->email, ['full_response' => $data]);

            if(isset($data['IsErroredOnProcessing']) && $data['IsErroredOnProcessing'] == true) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Lỗi OCR: ' . implode(", ", $data['ErrorMessage'] ?? ['Không thể xử lý ảnh giấy phép.'])
                ], 422);
            }

            $parsedText = "";
            if(!empty($data['ParsedResults']) && isset($data['ParsedResults'][0])) {
                $rawText = mb_strtolower($data['ParsedResults'][0]['ParsedText'], 'UTF-8');
                $parsedText = $this->removeVietnameseTones($rawText);
            }

            // Dò bằng các từ khóa KHÔNG DẤU để tăng độ chính xác của OCR
            $keywords = ['doanh nghiep', 'giay phep', 'chung nhan', 'cong ty', 'ma so', 'dang ky', 'dia chi', 'tru so', 'mst'];
            
            $matchCount = 0;
            $foundKeywords = [];
            foreach($keywords as $keyword) {
                if(str_contains($parsedText, $keyword)) {
                    $matchCount++;
                    $foundKeywords[] = $keyword;
                }
            }

            Log::info("OCR Result for " . $request->email, [
                'parsed_text_preview' => mb_substr($parsedText, 0, 500),
                'match_count' => $matchCount,
                'found_keywords' => $foundKeywords
            ]);

            // Require at least 2 keywords for better reliability (Adjusted back to 2 as OCR can miss words)
            if($matchCount < 2) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'Ảnh tải lên không hợp lệ, không thể xác nhận đây là Giấy phép kinh doanh.'
                ], 422);
            }

            $user = User::create([
                'name' => $request->name,
                'email' => $request->email,
                'password' => Hash::make($request->password),
                'phone' => $request->phone,
                'business_license_url' => $imgUrl,
                'role' => 2 
            ]);

            return response()->json([
                'status' => 'success',
                'message' => 'Đăng ký thành công nhà quản lý!',
                'data' => $user
            ], 201);
        }

        return response()->json([
            'status' => 'error',
            'message' => 'Không thể kết nối đến máy chủ OCR để xác thực giấy phép.'
        ], 500);
    }

    private function removeVietnameseTones($str)
    {
        $str = preg_replace("/(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)/", "a", $str);
        $str = preg_replace("/(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)/", "e", $str);
        $str = preg_replace("/(ì|í|ị|ỉ|ĩ)/", "i", $str);
        $str = preg_replace("/(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)/", "o", $str);
        $str = preg_replace("/(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)/", "u", $str);
        $str = preg_replace("/(ỳ|ý|ỵ|ỷ|ỹ)/", "y", $str);
        $str = preg_replace("/(đ)/", "d", $str);
        return strtolower($str);
    }
}
