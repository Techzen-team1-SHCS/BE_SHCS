#!/usr/bin/env bash

echo "Starting Laravel Reverb..."

composer install --no-dev --optimize-autoloader

php artisan config:cache

php artisan reverb:start --host=0.0.0.0 --port=$PORT