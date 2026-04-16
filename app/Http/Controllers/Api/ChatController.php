<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Support\ChatSlotContext;
use App\Support\ChatSlotParser;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ChatController extends Controller
{
    public function stream(Request $request)
    {
        $question = trim((string) $request->input('message'));
        $userId = (int) optional($request->user())->id;

        if ($question === '') {
            return response()->json([
                'status' => 400,
                'message' => 'Thiếu câu hỏi',
            ], 400);
        }

        $incomingSlots = ChatSlotParser::extract($question);
        $context = $userId
            ? ChatSlotContext::merge($userId, $incomingSlots)
            : array_merge(ChatSlotContext::emptyContext(), $incomingSlots);

        $missingSlots = ChatSlotParser::missingSlots($context);
        if (!empty($missingSlots)) {
            return response()->json([
                'status' => 200,
                'reply' => $this->buildSlotFollowUp($missingSlots),
                'hotels' => [],
                'explanation' => null,
            ]);
        }

        $hotels = $this->loadHotels();
        $filteredHotels = $this->filterHotelsByContext($hotels, $context);

        if (empty($filteredHotels)) {
            return response()->json([
                'status' => 200,
                'reply' => $this->buildNoResultReply($context),
                'hotels' => [],
                'explanation' => null,
            ]);
        }

        $rankedHotels = $this->rankHotelsByContext($filteredHotels, $context);
        $reply = $this->buildContextReply($context, count($rankedHotels));
        $explanation = $this->buildExplanation($rankedHotels, $context);
        $reply = $this->dedupeReply($reply, $question, $context, $explanation);

        return response()->json([
            'status' => 200,
            'reply' => $reply,
            'hotels' => $rankedHotels,
            'explanation' => $explanation,
        ]);
    }

    private function loadHotels(): array
    {
        return DB::table('hotels')
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
            ->limit(60)
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
                    'price_value' => (int) $hotel->price,
                    'stars' => $hotel->hotel_class ? str_repeat('⭐', max(1, (int) ceil($hotel->hotel_class / 10))) : '⭐⭐⭐',
                    'description' => $hotel->description ?: $hotel->text,
                    'amenities' => $amenities,
                ];
            })
            ->toArray();
    }

    private function filterHotelsByContext(array $hotels, array $context): array
    {
        $filtered = array_filter($hotels, function ($hotel) use ($context) {
            if (!empty($context['province']) && mb_strtolower((string) $hotel['province']) !== mb_strtolower((string) $context['province'])) {
                return false;
            }

            if (!empty($context['budget_max']) && (int) $hotel['price_value'] > (int) $context['budget_max']) {
                return false;
            }

            if (!empty($context['budget_min']) && (int) $hotel['price_value'] < (int) $context['budget_min']) {
                return false;
            }

            if (!empty($context['view']) && $context['view'] === 'sea') {
                $haystack = mb_strtolower((string) ($hotel['description'] ?? '') . ' ' . (string) ($hotel['amenities'] ?? ''));
                if (!str_contains($haystack, 'biển') && !str_contains($haystack, 'sea')) {
                    return false;
                }
            }

            return true;
        });

        return array_values($filtered);
    }

    private function buildSlotFollowUp(array $missingSlots): string
    {
        if (in_array('province', $missingSlots, true) && in_array('guests', $missingSlots, true)) {
            return 'Dạ, anh/chị cho em xin tỉnh thành muốn đi và số người ở để em gợi ý khách sạn phù hợp nhất ạ?';
        }

        if (in_array('province', $missingSlots, true)) {
            return 'Dạ, anh/chị cho em xin tỉnh thành muốn đặt khách sạn ạ?';
        }

        if (in_array('guests', $missingSlots, true)) {
            return 'Dạ, anh/chị cho em xin số người ở để em lọc khách sạn phù hợp hơn ạ?';
        }

        return 'Dạ, anh/chị cho em thêm thông tin để em tư vấn chính xác hơn ạ?';
    }

    private function buildNoResultReply(array $context): string
    {
        $parts = [];

        if (!empty($context['province'])) {
            $parts[] = 'Dạ, em chưa tìm được khách sạn phù hợp trong ' . $context['province'];
        } else {
            $parts[] = 'Dạ, em chưa tìm được khách sạn phù hợp';
        }

        if (!empty($context['budget_max'])) {
            $parts[] = 'với ngân sách tối đa ' . number_format($context['budget_max'], 0, ',', '.') . ' VND';
        }

        $parts[] = '. Anh/chị thử mở rộng khu vực hoặc tăng ngân sách giúp em nhé.';

        return implode(' ', $parts);
    }

    private function buildContextReply(array $context, int $count): string
    {
        $parts = [];

        if (!empty($context['province'])) {
            $parts[] = 'Dạ, em đã lọc khách sạn tại ' . $context['province'];
        }

        if (!empty($context['budget_max'])) {
            $parts[] = 'trong tầm giá tối đa ' . number_format($context['budget_max'], 0, ',', '.') . ' VND';
        }

        if (!empty($context['guests'])) {
            $parts[] = 'phù hợp cho ' . $context['guests'] . ' người';
        }

        if (!empty($context['view']) && $context['view'] === 'sea') {
            $parts[] = 'ưu tiên view biển';
        }

        $parts[] = 'Em tìm thấy ' . $count . ' khách sạn phù hợp nhất bên dưới ạ.';

        return implode(' ', $parts);
    }

    private function rankHotelsByContext(array $hotels, array $context): array
    {
        usort($hotels, function ($a, $b) use ($context) {
            return $this->hotelScore($b, $context) <=> $this->hotelScore($a, $context);
        });

        return array_slice($hotels, 0, 5);
    }

    private function hotelScore(array $hotel, array $context): int
    {
        $score = 0;
        $description = mb_strtolower((string) ($hotel['description'] ?? '') . ' ' . (string) ($hotel['amenities'] ?? '') . ' ' . (string) ($hotel['name_nearby_place'] ?? ''));

        $score += isset($hotel['stars']) ? (int) preg_replace('/\D+/', '', (string) $hotel['stars']) : 0;

        if (!empty($context['view']) && $context['view'] === 'sea') {
            $score += (str_contains($description, 'biển') || str_contains($description, 'sea')) ? 20 : 0;
        }

        if (!empty($context['budget_max']) && isset($hotel['price_value'])) {
            $distance = max(0, (int) $context['budget_max'] - (int) $hotel['price_value']);
            $score += $distance > 0 ? max(0, 15 - (int) floor($distance / 1000000)) : 0;
        }

        if (!empty($context['guests'])) {
            $score += 5;
        }

        return $score;
    }

    private function buildExplanation(array $hotels, array $context): string
    {
        if (empty($hotels)) {
            return '';
        }

        $reasons = [];
        if (!empty($context['province'])) {
            $reasons[] = 'đúng khu vực ' . $context['province'];
        }
        if (!empty($context['budget_max'])) {
            $reasons[] = 'giá nằm trong ngân sách';
        }
        if (!empty($context['view']) && $context['view'] === 'sea') {
            $reasons[] = 'ưu tiên các chỗ có thể gần biển hoặc view biển';
        }
        if (!empty($context['guests'])) {
            $reasons[] = 'phù hợp số người ở';
        }

        $reasonText = !empty($reasons) ? implode(', ', $reasons) : 'mức độ phù hợp cao nhất theo nhu cầu hiện tại';
        $names = array_map(static fn ($hotel) => $hotel['name'], $hotels);
        $names = array_slice($names, 0, 3);

        return 'Mình gợi ý các khách sạn này vì ' . $reasonText . '. Một vài lựa chọn nổi bật là ' . implode(', ', $names) . '. Mình có thể xem chi tiết từng khách sạn để chọn nơi phù hợp nhất cho mình ạ.';
    }

    private function dedupeReply(string $reply, string $question, array $context, string $explanation = ''): string
    {
        $reply = trim(preg_replace('/\s+/u', ' ', $reply) ?? $reply);
        $questionNormalized = mb_strtolower(trim(preg_replace('/\s+/u', ' ', $question) ?? $question));
        $replyNormalized = mb_strtolower($reply);

        if ($replyNormalized === $questionNormalized || $reply === '') {
            $reply = $this->buildContextReply($context, 0);
        }

        if ($explanation !== '') {
            $explanationNormalized = mb_strtolower(trim(preg_replace('/\s+/u', ' ', $explanation) ?? $explanation));
            if (!str_contains($replyNormalized, $explanationNormalized)) {
                $reply .= ' ' . $explanation;
            }
        }

        return $reply;
    }
}
