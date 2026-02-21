<?php

namespace App\Providers;

// use Illuminate\Support\Facades\Gate;

use App\Models\Booking;
use App\Models\Hotel;
use App\Policies\BookingPolicy;
use App\Policies\HM\HotelPolicy;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Laravel\Passport\Passport;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The model to policy mappings for the application.
     *
     * @var array<class-string, class-string>
     */
    protected $policies = [
        // Booking user
        Booking::class=>BookingPolicy::class,
        Hotel::class=>HotelPolicy::class
    ];

    /**
     * Register any authentication / authorization services.
     */
    public function boot(): void
    {
        $this->registerPolicies();
        Passport::tokensExpireIn(now()->addDays(15));
        Passport::refreshTokensExpireIn(now()->addDays(30));
        Passport::personalAccessTokensExpireIn(now()->addMonths(6));
    }
}
