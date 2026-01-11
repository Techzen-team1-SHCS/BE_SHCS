<?php
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
Route::get('/gemini-test', function () {
    $model = 'models/gemini-2.5-flash';

    $res = Http::post(
        "https://generativelanguage.googleapis.com/v1/$model:generateContent?key=" . env('GEMINI_API_KEY'),
        [
            'contents' => [[
                'parts' => [[
                    'text' => 'Hello Gemini from Laravel'
                ]]
            ]]
        ]
    )->json();

    return $res['candidates'][0]['content']['parts'][0]['text'] ?? $res;
});

