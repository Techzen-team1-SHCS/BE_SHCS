<?php

use App\Http\Controllers\Api\HotelController;
use App\Http\Controllers\Api\UserBehaviorController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\NotificationController;
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
    Route::post('/login', [UserController::class, 'login']);
    Route::post('/register', [UserController::class, 'register']);
    Route::post('/passwordRetrieval', [UserController::class, 'passwordRetrieval']);
    Route::post('/users', [UserController::class, 'addUser']);
    Route::get('/hotels/search', [HotelController::class, 'search']);
    Route::post('subscriber',[NotificationController::class,'store']);
    Route::group(['middleware' => 'auth:api'], function () {
        Route::post('/logout',[UserController::class,'logout']);
        Route::put('/update/{id}',[UserController::class,'update']);
        //UserBehavior
        Route::post('/user-behaviors/batch', [UserBehaviorController::class, 'batch']);
        //Hotel
        Route::get('/hotel',[HotelController::class,'index']);
        Route::get('/hotel/{id}',[HotelController::class,'show']);
        Route::post('/hotel',[HotelController::class,'store']);
        Route::put('/hotel/{id}',[HotelController::class,'update']);
        Route::delete('/hotel/{id}',[HotelController::class,'destroy']);
        //
    });
});
