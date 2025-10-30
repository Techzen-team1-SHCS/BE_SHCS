<?php

use App\Http\Controllers\Api\BookingController;
use App\Http\Controllers\Api\HotelController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\RecommendationController;
use App\Http\Controllers\Api\RoomController;
use App\Http\Controllers\Api\UserBehaviorController;
use App\Http\Controllers\Api\UserController;

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
    //user
    Route::post('/login', [UserController::class, 'login']);
    Route::post('/loginGoogle',[UserController::class,'loginGoogle']);
    Route::post('/register', [UserController::class, 'register']);
    Route::post('/passwordRetrieval', [UserController::class, 'passwordRetrieval']);
    Route::post('/users', [UserController::class, 'addUser']);
    Route::get('/hotels/search', [HotelController::class, 'search']);
    Route::post('subscriber',[NotificationController::class,'store']);
    Route::post('/forgot-password', [UserController::class, 'sendResetLink']);
    Route::post('/reset-password', [UserController::class, 'reset']);
    Route::get('/user/{id}',[UserController::class,'show']);
    //Hotel
    Route::get('hotels/{id}/same-style', [HotelController::class, 'sameStyle']);
    Route::get('hotels/{id}/same-province', [HotelController::class, 'sameProvince']);
    Route::get('/hotel/{id}',[HotelController::class,'show']);
    Route::post('/import-hotels-excel', [HotelController::class, 'importHotelStyles']);
    Route::post('/hotels/{hotel}/images', [HotelController::class, 'uploadImages']);
    Route::get('/tophotels',[HotelController::class,'topHotels']);
    Route::get('/hotel',[HotelController::class,'index']);
    //Room
    Route::get('/rooms',[RoomController::class,'index']);
    Route::get('/room',[RoomController::class,'show']);
    Route::group(['middleware' => 'auth:api'], function () {
        Route::post('/logout',[UserController::class,'logout']);
        Route::post('/update/{id}',[UserController::class,'update']);

        //UserBehavior
        Route::post('/user-behaviors/batch', [UserBehaviorController::class, 'batch']);
        //Hotel

        Route::post('/hotel',[HotelController::class,'store']);
        Route::put('/hotel/{id}',[HotelController::class,'update']);
        Route::delete('/hotel/{id}',[HotelController::class,'destroy']);
        //Room
        Route::post('/room',[RoomController::class,'store']);
        Route::put('/room/{id}',[RoomController::class,'update']);
        Route::delete('/room/{id}',[RoomController::class,'destroy']);
        // Recommendation
        Route::get('/recommendations/{user_id}', [RecommendationController::class, 'getRecommendations']);
        //Booking
        Route::get('/booking',[BookingController::class,'index']);
        Route::get('/booking/{id}',[BookingController::class,'show']);
        Route::post('/booking',[BookingController::class,'store']);
        Route::put('/booking/{id}',[BookingController::class,'update']);
        Route::delete('/booking/{id}',[BookingController::class,'destroy']);
    });
});
