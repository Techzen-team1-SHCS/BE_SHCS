<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class CheckMaintenance
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Bypass auth routes
        if ($request->is('api/auth/login') || $request->is('api/auth/register') || $request->is('api/auth/hotel-manager/register') || $request->is('api/auth/loginGoogle')) {
            return $next($request);
        }

        $isMaintenance = \App\Models\SystemSetting::where('setting_key', 'is_maintenance')->value('setting_value');

        // Check if user is logged in and is admin
        $user = auth('api')->user();
        if ($user && $user->role == 1) {
            return $next($request);
        }

        if ($isMaintenance == 1) {
            if ($request->expectsJson() || $request->is('api/*')) {
                return response()->json([
                    'message' => 'Hệ thống đang nâng cấp để phục vụ bạn tốt hơn. Dự kiến quay lại lúc: Sớm nhất có thể.',
                    'is_maintenance' => true
                ], 503);
            }
            return redirect('/maintenance');
        }

        return $next($request);
    }
}
