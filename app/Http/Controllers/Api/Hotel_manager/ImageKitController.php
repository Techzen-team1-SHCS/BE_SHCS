<?php

namespace App\Http\Controllers\Api\Hotel_manager;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use ImageKit\ImageKit;

class ImageKitController extends Controller
{
    public function getAuthParams(){
        $imageKit=new ImageKit(
            env('IMAGEKIT_PUBLIC_KEY'),
            env('IMAGEKIT_PRIVATE_KEY'),
            env('IMAGEKIT_URL_ENDPOINT')
        );
        $authParams=$imageKit->getAuthenticationParameters();
        return response()->json($authParams);
    }
}
