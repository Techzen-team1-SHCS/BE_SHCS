<?php

namespace App\Support;

use Illuminate\Support\Facades\Cache;

class ChatSlotContext
{
    private const TTL_SECONDS = 1800;
    private const CACHE_PREFIX = 'chat_slot_context:';

    public static function get(int $userId): array
    {
        return Cache::get(self::CACHE_PREFIX . $userId, self::emptyContext());
    }

    public static function put(int $userId, array $context): void
    {
        Cache::put(self::CACHE_PREFIX . $userId, array_merge(self::emptyContext(), $context), self::TTL_SECONDS);
    }

    public static function merge(int $userId, array $incoming): array
    {
        $context = array_merge(self::get($userId), array_filter($incoming, static fn ($value) => $value !== null && $value !== ''));
        self::put($userId, $context);

        return $context;
    }

    public static function clear(int $userId): void
    {
        Cache::forget(self::CACHE_PREFIX . $userId);
    }

    public static function emptyContext(): array
    {
        return [
            'province' => null,
            'budget_min' => null,
            'budget_max' => null,
            'view' => null,
            'guests' => null,
            'room_type' => null,
            'purpose' => null,
            'check_in' => null,
            'check_out' => null,
        ];
    }
}
