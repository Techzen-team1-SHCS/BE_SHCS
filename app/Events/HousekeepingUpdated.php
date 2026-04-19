<?php

namespace App\Events;

use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Contracts\Broadcasting\ShouldBroadcastNow;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class HousekeepingUpdated implements ShouldBroadcastNow
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public string $scope;
    public string $action;
    public ?int $hotelId;
    public array $payload;

    public function __construct(string $scope, string $action, ?int $hotelId = null, array $payload = [])
    {
        $this->scope = $scope;
        $this->action = $action;
        $this->hotelId = $hotelId;
        $this->payload = $payload;
    }

    public function broadcastOn(): array
    {
        $channels = [new PrivateChannel('hotel-manager.housekeeping')];

        if ($this->hotelId) {
            $channels[] = new PrivateChannel('hotel-manager.housekeeping.hotel.' . $this->hotelId);
        }

        return $channels;
    }

    public function broadcastAs(): string
    {
        return 'HousekeepingUpdated';
    }

    public function broadcastWith(): array
    {
        return [
            'scope' => $this->scope,
            'action' => $this->action,
            'hotel_id' => $this->hotelId,
            'payload' => $this->payload,
            'occurred_at' => now()->toIso8601String(),
        ];
    }
}
