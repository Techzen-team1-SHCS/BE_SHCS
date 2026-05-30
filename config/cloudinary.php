<?php

return [
    // Cloudinary Laravel expects cloud_url for config
    'cloud_url'  => env('CLOUDINARY_URL'),
    // keep backward-compatible alias
    'url'        => env('CLOUDINARY_URL'),
    'cloud_name' => env('CLOUDINARY_CLOUD_NAME'),
    'api_key'    => env('CLOUDINARY_API_KEY'),
    'api_secret' => env('CLOUDINARY_API_SECRET'),
];
