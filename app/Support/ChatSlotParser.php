<?php

namespace App\Support;

class ChatSlotParser
{
    public static function extract(string $message): array
    {
        $text = mb_strtolower(trim($message));
        $context = [];

        if (preg_match('/\b(?:đà nẵng|da nang|nha trang|phú quốc|phu quoc|vũng tàu|vung tau|quy nhơn|quy nhon|huế|hue|sầm sơn|sam son|quảng ninh|quang ninh|đà lạt|da lat|hà nội|ha noi|hồ chí minh|tp\.hcm|hcm|kiên giang|kien giang|bình định|binh dinh|khánh hòa|khanh hoa)\b/u', $text, $m)) {
            $context['province'] = self::normalizeProvince($m[0]);
        }

        if (preg_match('/\b(1\s*triệu|2\s*triệu|3\s*triệu|4\s*triệu|5\s*triệu|10\s*triệu)\b/u', $text, $m)) {
            $budget = (int) preg_replace('/\D+/', '', $m[0]) * 1000000;
            $context['budget_max'] = $budget;
        }

        if (preg_match('/\b(dưới|tối đa|không quá)\s*(\d+[\.,]?\d*)\s*triệu\b/u', $text, $m)) {
            $context['budget_max'] = (int) ((float) str_replace(',', '.', $m[2]) * 1000000);
        }

        if (preg_match('/\b(từ|trên)\s*(\d+[\.,]?\d*)\s*triệu\b/u', $text, $m)) {
            $context['budget_min'] = (int) ((float) str_replace(',', '.', $m[2]) * 1000000);
        }

        if (preg_match('/\b(view\s*biển|biển đẹp|sea view)\b/u', $text)) {
            $context['view'] = 'sea';
        }

        if (preg_match('/\b(\d+)\s*(người|khách|pax)\b/u', $text, $m)) {
            $context['guests'] = (int) $m[1];
        }

        if (preg_match('/\b(deluxe|standard|suite|family|vip|superior)\b/u', $text, $m)) {
            $context['room_type'] = mb_strtoupper($m[1]);
        }

        if (preg_match('/\b(du lịch|nghỉ dưỡng|công tác|honeymoon|hẹn hò|gia đình)\b/u', $text, $m)) {
            $context['purpose'] = $m[1];
        }

        return array_filter($context, static fn ($value) => $value !== null && $value !== '');
    }

    public static function missingSlots(array $context): array
    {
        $missing = [];

        if (empty($context['province'])) $missing[] = 'province';
        if (empty($context['guests'])) $missing[] = 'guests';

        return $missing;
    }

    private static function normalizeProvince(string $value): string
    {
        $map = [
            'da nang' => 'Đà Nẵng',
            'đà nẵng' => 'Đà Nẵng',
            'nha trang' => 'Nha Trang',
            'phú quốc' => 'Phú Quốc',
            'phu quoc' => 'Phú Quốc',
            'vũng tàu' => 'Vũng Tàu',
            'vung tau' => 'Vũng Tàu',
            'quy nhơn' => 'Quy Nhơn',
            'quy nhon' => 'Quy Nhơn',
            'huế' => 'Huế',
            'hue' => 'Huế',
            'sầm sơn' => 'Sầm Sơn',
            'sam son' => 'Sầm Sơn',
            'quảng ninh' => 'Quảng Ninh',
            'quang ninh' => 'Quảng Ninh',
            'đà lạt' => 'Đà Lạt',
            'da lat' => 'Đà Lạt',
            'hà nội' => 'Hà Nội',
            'ha noi' => 'Hà Nội',
            'hồ chí minh' => 'Hồ Chí Minh',
            'tp.hcm' => 'Hồ Chí Minh',
            'hcm' => 'Hồ Chí Minh',
            'kiên giang' => 'Kiên Giang',
            'kien giang' => 'Kiên Giang',
            'bình định' => 'Bình Định',
            'binh dinh' => 'Bình Định',
            'khánh hòa' => 'Khánh Hòa',
            'khanh hoa' => 'Khánh Hòa',
        ];

        $normalized = mb_strtolower(trim($value));
        return $map[$normalized] ?? ucfirst($normalized);
    }
}
