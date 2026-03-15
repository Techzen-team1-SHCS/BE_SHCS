#!/usr/bin/env bash

echo "Running composer"
composer global require hirak/prestissimo
composer install --no-dev --working-dir=/var/www/html

echo "Generating application key..."
php artisan key:generate --force

echo "Creating passport keys..."
php artisan passport:keys --force

echo "Caching config..."
php artisan config:cache

echo "Clearing config..."
php artisan config:clear

echo "Caching routes..."
php artisan route:cache

echo "Running migrations..."
php artisan migrate --force

echo "Create folders..."
mkdir -p storage/logs
chmod -R 775 storage bootstrap/cache

echo "Starting queue worker..."
php artisan queue:work --tries=3 --timeout=90 &

echo "Starting services..."