<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Comment;
use App\Models\Hotel;
use App\Models\Room;
use App\Models\User;
use Carbon\Carbon;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;
use Laravel\Reverb\Loggers\Log;


class DashboardController extends Controller
{
    public function getRevenue(){
        $TotalRevenue = \App\Models\Booking::where('status', 'completed')
            ->sum('total_price');
        return response()->json([
            'status'=>200,
            'data'=>$TotalRevenue
        ]);
    }
    public function getBookingsByMonth(Request $request)
    {
        $month = $request->query('month'); // 1-12 hoặc null
        $year  = $request->query('year');  // 4 chữ số hoặc null

        if (!$month || !$year) {
            // Lấy tháng gần nhất có booking
            $latestBooking = Booking::orderBy('created_at', 'desc')->first();
            if (!$latestBooking) {
                return response()->json([
                    'status' => false,
                    'message' => 'No bookings found',
                    'total' => 0,
                    'data' => []
                ]);
            }

            $month = Carbon::parse($latestBooking->created_at)->month;
            $year = Carbon::parse($latestBooking->created_at)->year;
        }

        // Lấy danh sách booking
        $bookings = Booking::whereYear('created_at', $year)
                           ->whereMonth('created_at', $month)
                           ->orderBy('created_at', 'desc')
                           ->get();

        $totalBooking = $bookings->count();

        return response()->json([
            'status' => true,
            'month' => $month,
            'year' => $year,
            'total' => $totalBooking,
            'data' => $bookings
        ]);
    }
     public function getBookingsChart(Request $request)
    {
        $type = $request->query('type', 'monthly'); // default: monthly

        if ($type === 'monthly') {
            $data = Booking::selectRaw('MONTH(created_at) as month, COUNT(*) as total')
                ->whereYear('created_at', now()->year)
                ->groupBy('month')
                ->orderBy('month')
                ->get();

            $labels = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
            $chartData = array_fill(0, 12, 0);

            foreach($data as $item){
                $chartData[$item->month - 1] = (int)$item->total;
            }

            return response()->json([
                'status' => 200,
                'labels' => $labels,
                'data' => $chartData
            ]);
        }

        if ($type === 'weekly') {
            $data = Booking::selectRaw('WEEK(created_at) - WEEK(DATE_SUB(created_at, INTERVAL DAY(created_at)-1 DAY)) + 1 as week, COUNT(*) as total')
                ->whereMonth('created_at', now()->month)
                ->whereYear('created_at', now()->year)
                ->groupBy('week')
                ->orderBy('week')
                ->get();

            $labels = ['Week 1','Week 2','Week 3','Week 4'];
            $chartData = array_fill(0, 4, 0);

            foreach($data as $item){
                $chartData[$item->week - 1] = (int)$item->total;
            }

            return response()->json([
                'status' => 200,
                'labels' => $labels,
                'data' => $chartData
            ]);
        }

        if ($type === 'daily') {
            $data = Booking::selectRaw('DAYOFWEEK(created_at) as day, COUNT(*) as total')
                ->whereBetween('created_at', [now()->startOfWeek(), now()->endOfWeek()])
                ->groupBy('day')
                ->orderBy('day')
                ->get();

            $labels = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
            $chartData = array_fill(0, 7, 0);

            foreach($data as $item){
                $chartData[$item->day - 1] = (int)$item->total;
            }

            return response()->json([
                'status' => 200,
                'labels' => $labels,
                'data' => $chartData
            ]);
        }

        return response()->json([
            'status' => 400,
            'message' => 'Invalid type'
        ]);
    }

    public function getTopHotelsByBookings(){
        $topHotels = Hotel::withCount(['bookings as booking_count'])
        ->orderBy('booking_count', 'desc')
        ->limit(5)
        ->get(['id', 'name']);

        return response()->json([
            'status'=>true,
            'data'=>$topHotels
        ],200);
    }
    public function getTodayBookings()
    {
        // Lấy ngày hiện tại
        $today = Carbon::today(); // 00:00:00 của hôm nay
        $tomorrow = Carbon::tomorrow(); // 00:00:00 của ngày mai

        // Query bookings trong ngày hôm nay
        $bookings = Booking::whereBetween('created_at', [$today, $tomorrow])
            ->with('room','room.hotel')
            ->with('user')
            ->get();

        return response()->json([
            'status' => true,
            'data' => $bookings
        ]);
    }
    public function getRoomStats()
    {
        $quantityAgg = DB::table('rooms')
            ->selectRaw('rooms.room_type as room_type, COALESCE(SUM(rooms.quantity), 0) as total_quantity')
            ->groupBy('rooms.room_type')
            ->get()
            ->keyBy('room_type');

        $bookingAgg = DB::table('rooms')
            ->leftJoin('bookings', function ($join) {
                $join->on('bookings.room_id', '=', 'rooms.id')
                    ->where('bookings.status', '!=', 'cancelled');
            })
            ->selectRaw('rooms.room_type as room_type, COALESCE(SUM(bookings.quantity), 0) as total_bookings')
            ->groupBy('rooms.room_type')
            ->get()
            ->keyBy('room_type');

        $ratingAgg = DB::table('rooms')
            ->leftJoin('comments', 'comments.hotel_id', '=', 'rooms.hotel_id')
            ->selectRaw('rooms.room_type as room_type, ROUND(AVG(comments.rating), 1) as average_rating')
            ->groupBy('rooms.room_type')
            ->get()
            ->keyBy('room_type');

        $roomTypes = Room::query()->select('room_type')->distinct()->pluck('room_type');

        $data = $roomTypes->map(function ($roomType) use ($quantityAgg, $bookingAgg, $ratingAgg) {
            $totalQuantity = (int) ($quantityAgg[$roomType]->total_quantity ?? 0);
            $totalBookings = (int) ($bookingAgg[$roomType]->total_bookings ?? 0);
            $averageRating = (float) ($ratingAgg[$roomType]->average_rating ?? 0);

            return [
                'roomType' => $roomType,
                'totalBookings' => $totalBookings,
                'occupancyRate' => $totalQuantity > 0 ? round(($totalBookings / $totalQuantity) * 100) . '%' : '0%',
                'averageRating' => $averageRating,
            ];
        })->values();

        return response()->json($data);
    }
    public function getDashboardStats()
    {
        // 1️⃣ Occupancy Rate
        $occupied = Booking::sum('quantity');

        $totalRooms = Room::sum('quantity');
        $occupancyRate = $totalRooms > 0
            ? round(($occupied / $totalRooms) * 100) . '%'
            : '0%';
        // 2️⃣ Pending Reservations
        $pendingReservations = Booking::where('status', 'pending')->count();

        // 3️⃣ Average Rating
        $averageRating = round(Comment::avg('rating') ?? 0, 1);

        // 4️⃣ Monthly Reservations (12 tháng)
        $monthlyReservations = Booking::select(
                                DB::raw('MONTH(check_in) as month'),
                                DB::raw('COUNT(*) as total')
                             )
                             ->groupBy('month')
                             ->orderBy('month')
                             ->get()
                             ->mapWithKeys(function ($item) {
                                return [$item->month => $item->total];
                             });

        // 5️⃣ Guest Satisfaction
        $totalReviews = Comment::count();
        $guestSatisfaction = [
            'excellent' => $totalReviews ? round(Comment::where('rating','>=',4.5)->count() / $totalReviews * 100) : 0,
            'good'      => $totalReviews ? round(Comment::whereBetween('rating',[3,4.49])->count() / $totalReviews * 100) : 0,
            'poor'      => $totalReviews ? round(Comment::where('rating','<',3)->count() / $totalReviews * 100) : 0,
        ];

        // 🔹 Return JSON
        return response()->json([
            'occupancyRate' => $occupancyRate,
            'pendingReservations' => $pendingReservations,
            'averageRating' => $averageRating,
            'monthlyReservations' => $monthlyReservations,
            'guestSatisfaction' => $guestSatisfaction,
        ]);
    }
    public function dashboardStats(){
        return Cache::remember('dashboard_stats', 5, function () {
            return [
                'revenue' => Booking::sum(DB::raw('COALESCE(final_price, total_price)')),
                'bookingMonth' => Booking::whereMonth('created_at', now()->month)->count(),
                'userCount' => User::count(),
            ];
        });
    }
    public function summary()
    {
        try {
            $now = Carbon::now();

            $data = Cache::remember('dashboard_summary', 60, function () use ($now) {

                $revenue = Booking::where('status', 'completed')
                    ->sum('total_price');

                $newBooking = Booking::whereBetween('created_at', [
                    $now->copy()->startOfMonth(),
                    $now->copy()->endOfMonth()
                ])->count();

                $userActive = User::where('role', 0)->count();

                return [
                    'revenue' => $revenue,
                    'new_booking' => $newBooking,
                    'user_active' => $userActive,
                ];
            });

            return response()->json([
                'status' => 200,
                'data' => $data
            ], 200);

        } catch (\Throwable $e) {
            return response()->json([
                'status' => 500,
                'message' => 'Failed to load dashboard',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
