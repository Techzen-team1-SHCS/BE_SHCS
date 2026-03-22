<?php

use App\Http\Controllers\Api\Admin\AdminHotelController;
use App\Http\Controllers\Api\BlockController;
use App\Http\Controllers\Api\BookingController;
use App\Http\Controllers\Api\ChatController;
use App\Http\Controllers\Api\CommentController;
use App\Http\Controllers\Api\DashboardController;
use App\Http\Controllers\Api\DiscountController;
use App\Http\Controllers\Api\Hotel_manager\HM_BookingController;
use App\Http\Controllers\Api\Hotel_manager\HM_HotelController;
use App\Http\Controllers\Api\Hotel_manager\HM_RoomController;
use App\Http\Controllers\Api\HotelController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\RecommendationController;
use App\Http\Controllers\Api\RoomController;
use App\Http\Controllers\Api\UserBehaviorController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\WishListController;
use App\Http\Controllers\Api\SupportTicketController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/


Route::group(['prefix' => 'auth'], function () {
    Route::post('/chat/stream', [ChatController::class, 'stream']);
    //user
    Route::post('/login', [UserController::class, 'login']);
    Route::post('/loginGoogle', [UserController::class, 'loginGoogle']);
    Route::post('/register', [UserController::class, 'register']);
    Route::post('/passwordRetrieval', [UserController::class, 'passwordRetrieval']);
    Route::post('/users', [UserController::class, 'addUser']);
    Route::get('/hotels/search', [HotelController::class, 'search']);
    Route::post('subscriber', [NotificationController::class, 'store']);
    Route::post('/forgot-password', [UserController::class, 'sendResetLink']);
    Route::post('/reset-password', [UserController::class, 'reset']);
    Route::get('/user/{id}', [UserController::class, 'show']);
    Route::get('user', [UserController::class, 'index']);
    //Hotel
    Route::get('hotels/{id}/same-style', [HotelController::class, 'sameStyle']);
    Route::get('hotels/{id}/same-province', [HotelController::class, 'sameProvince']);
    Route::get('/hotel/{id}', [HotelController::class, 'show']);
    Route::post('/import-hotels-excel', [HotelController::class, 'importHotelStyles']);
    Route::get('/tophotels', [HotelController::class, 'topHotels']);
    Route::get('/hotel', [HotelController::class, 'index']);
    Route::get('/destinations/count', [HotelController::class, 'destinationsCount']);
    Route::get('discount', [DiscountController::class, 'index']);
    //Room
    Route::get('/rooms', [RoomController::class, 'index']);
    Route::get('/room', [RoomController::class, 'show']);
    Route::get('/hotels/{hotelId}/available-rooms', [RoomController::class, 'getAvailableRooms']);
    //Payment
    Route::get('/vnpay/return', [PaymentController::class, 'vnpayReturn']);
    //Comments
    Route::get('/comments', [CommentController::class, 'index']);
    //Booking
    Route::get('/booking', [BookingController::class, 'index']);
    //Ticket Support
    Route::post('/support-tickets', [SupportTicketController::class, 'store']);


    //discount
    Route::post('/booking/{id}/apply-discount', [DiscountController::class, 'applyDiscount']);
    Route::group(['middleware' => 'auth:api'], function () {

        Route::post('/logout', [UserController::class, 'logout']);
        Route::post('/user/update/{id}', [UserController::class, 'update']);
        Route::post('/user/upload-avatar/{id}', [UserController::class, 'uploadAvatar']);
        //UserBehavior
        Route::post('/user-behaviors/batch', [UserBehaviorController::class, 'batch']);
        Route::post('/behaviors/approve/user/{id}', [UserBehaviorController::class, 'approveUser']);
        // Recommendation
        Route::get('/recommendations', [RecommendationController::class, 'getRecommendations']);
        //Booking
        Route::get('/booking/{id}', [BookingController::class, 'show']);
        Route::get('bookings/user', [BookingController::class, 'getBookingUser']);
        Route::post('/booking', [BookingController::class, 'store']);
        Route::put('/booking/{id}', [BookingController::class, 'update']);
        Route::delete('/booking/{id}', [BookingController::class, 'destroy']);
        Route::post('/booking/cancel/{id}', [BookingController::class, 'cancel']);
        // Tạo comment mới
        Route::post('/comments', [CommentController::class, 'store']);
        // Sửa comment
        Route::put('/comments/{id}', [CommentController::class, 'update']);
        // Xóa comment
        Route::delete('/comments/{id}', [CommentController::class, 'destroy']);
        //Payment
        Route::get('/payments', [PaymentController::class, 'index']);
        Route::post('/vnpay/create-payment', [PaymentController::class, 'createPayment']);
        Route::get('/rooms/{id}/realtime', [BookingController::class, 'getRealtimeQuantity']);
        //WishList
        Route::get('/wishlist', [WishListController::class, 'index']);
        Route::get('/Mywishlist', [WishListController::class, 'show']);
        Route::post('/wishlist', [WishListController::class, 'store']);
        Route::delete('/wishlist/{id}', [WishListController::class, 'destroy']);
        Route::delete('/remove/like', [WishListController::class, 'removeLike']);
        Route::get('/wishlist/check', [WishListController::class, 'check']);
        //Notification
        Route::get('Allnotifications', [NotificationController::class, 'getAllAdmin']);
        Route::get('/notifications', [NotificationController::class, 'index']);
        Route::put('/notifications/{id}/read', [NotificationController::class, 'markAsRead']);
        Route::put('/notifications/mark-all-read', [NotificationController::class, 'markAllAsRead']);
        //Support Ticket
        Route::get('/support-tickets', [SupportTicketController::class, 'index']);
        Route::get('/support-tickets/{id}', [SupportTicketController::class, 'show']);
        //Block_user
        Route::post('/users/{id}/block', [BlockController::class, 'blockUser']);
        Route::post('/users/{id}/unblock', [BlockController::class, 'unblockUser']);
        //Admin Dashboard
        Route::get('/dashboard/summary', [DashboardController::class, 'summary']);
        Route::get('/dashboard/revenue', [DashboardController::class, 'getRevenue']);
        Route::get('/dashboard/by_month', [DashboardController::class, 'getBookingsByMonth']);
        Route::get('dashboard/bookings-chart', [DashboardController::class, 'getBookingsChart']);
        Route::get('dashboard/topHotelChart', [DashboardController::class, 'getTopHotelsByBookings']);
        Route::get('dashboard/todayBooking', [DashboardController::class, 'getTodayBookings']);
        Route::get('dashboard/getRoom', [DashboardController::class, 'getRoomStats']);
        Route::get('dashboard/getStats', [DashboardController::class, 'getDashboardStats']);
        Route::get('dashboardStart', [DashboardController::class, 'dashboardStats']);
        //Discount
        Route::post('/discount', [DiscountController::class, 'store']);
    });
    Route::middleware(['auth:api', 'role:1'])->group(function () {
        //Hotel
        Route::get('/admin/hotels/pending', [AdminHotelController::class, 'hotelsPending']);
        Route::post('/admin/hotel/{id}/approve', [AdminHotelController::class, 'approveHotel']);
        Route::post('/admin/hotel/{id}/reject', [AdminHotelController::class, 'rejectHotel']);
        Route::post('/hotel', [HotelController::class, 'store']);
        Route::put('/hotel/{id}', [HotelController::class, 'update']);
        Route::delete('/hotel/{id}', [HotelController::class, 'destroy']);
        //Room
        Route::post('/room', [RoomController::class, 'store']);
        Route::put('/room/{id}', [RoomController::class, 'update']);
        Route::delete('/room/{id}', [RoomController::class, 'destroy']);
    });
    Route::middleware(['auth:api','role:2'])->prefix('hotel-manager')->group(function(){
        Route::get('/hotels', [HM_HotelController::class, 'owner']);
        Route::post('/hotels', [HM_HotelController::class, 'create_owner']);
        Route::post('/hotels/{id}', [HM_HotelController::class, 'update_owner']);
        Route::delete('hotels/{id}',[HM_HotelController::class,'destroy_owner']);
        Route::post('/hotels/{hotel}/images', [HotelController::class, 'uploadImages']);

        //rooms
        Route::get('/rooms', [HM_RoomController::class, 'rooms']);
        Route::post('/rooms', [HM_RoomController::class, 'store_room']);
        Route::post('/rooms/{id}', [HM_RoomController::class, 'update_room']);
        Route::delete('rooms/{id}',[HM_RoomController::class,'delete_room']);
        
        //booking
        Route::post('/bookings', [HM_BookingController::class, 'bookings']);
        Route::post('/bookings/{id}', [HM_BookingController::class, 'update_booking_status']);
    });
});