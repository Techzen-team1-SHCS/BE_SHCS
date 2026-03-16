#!/usr/bin/env bash

echo "Install dependencies"
composer install --no-dev --optimize-autoloader

echo "Cache config"
php artisan config:cache
php artisan route:cache

echo "Start Reverb"
php artisan reverb:start --host=0.0.0.0 --port=8080 &

echo "Starting nginx..."
/start.sh