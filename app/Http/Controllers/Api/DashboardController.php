<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Booking;
use App\Models\Hotel;
use Carbon\Carbon;
use Illuminate\Http\Request;

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
            ->with('room')  // nếu muốn join thông tin phòng
            ->with('user')  // nếu muốn join thông tin user
            ->get();

        return response()->json([
            'status' => true,
            'data' => $bookings
        ]);
    }


}
