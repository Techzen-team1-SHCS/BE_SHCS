<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Comment;
use App\Models\Hotel;
use App\Models\Room;
use Carbon\Carbon;

use Illuminate\Http\Request;
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
        $rooms = Room::select('id','room_type', 'hotel_id', 'quantity')
            ->with(['hotel.comments', 'bookings'])
            ->get()
            ->groupBy('room_type')
            ->map(function ($groupedRooms) {

                $roomType = $groupedRooms->first()->room_type;

                // Log thông tin groupedRooms
                \Log::info("Grouped rooms for type {$roomType}: " . json_encode($groupedRooms->pluck('id')->toArray()));

                // Tổng số bookings theo room_type
                $totalBookings = $groupedRooms->sum(function ($room) {
                    // Log info từng room
                    \Log::info("Room {$room->id} ({$room->room_type}) bookings: " . json_encode([
                        'bookings_count' => $room->bookings->count(),
                        'bookings_quantity' => $room->bookings->sum('quantity'),
                        'booking_ids' => $room->bookings->pluck('id')->toArray()
                    ]));

                    return $room->bookings->sum('quantity');
                });

                // Tổng số phòng theo room_type
                $totalQuantity = $groupedRooms->sum('quantity');

                // Occupancy Rate
                $occupancyRate = $totalQuantity > 0
                    ? round(($totalBookings / $totalQuantity) * 100) . '%'
                    : '0%';

                // Ratings lấy từ comment của khách sạn
                $ratings = collect();
                foreach ($groupedRooms as $room) {
                    if ($room->hotel && $room->hotel->comments) {
                        $ratings = $ratings->merge(
                            $room->hotel->comments->pluck('rating')->filter()
                        );
                    }
                }

                $averageRating = $ratings->count() > 0
                    ? round($ratings->avg(), 1)
                    : 0;

                return [
                    'roomType' => $roomType,
                    'totalBookings' => $totalBookings,
                    'occupancyRate' => $occupancyRate,
                    'averageRating' => $averageRating
                ];
            })
            ->values();

        \Log::info("Final room stats: " . json_encode($rooms));

        return response()->json($rooms);
    }
    public function getDashboardStats()
    {
        // 1️⃣ Occupancy Rate
        $occupied = Booking::whereDate('check_in', '<=', today())
                           ->whereDate('check_out', '>=', today())
                           ->sum('quantity');

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


}
