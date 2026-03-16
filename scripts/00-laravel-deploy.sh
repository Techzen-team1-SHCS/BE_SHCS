#!/usr/bin/env bash

echo "Running composer"
composer install --no-dev --working-dir=/var/www/html

echo "Generating application key..."
php artisan key:generate --force || true

echo "Creating passport keys..."
php artisan passport:keys --force || true

echo "Running migrations..."
php artisan migrate --force || true

echo "Caching config..."
php artisan config:cache

echo "Caching routes..."
php artisan route:cache

echo "Create folders..."
mkdir -p storage/logs
chmod -R 775 storage bootstrap/cache

echo "Starting queue worker..."
php artisan queue:work --tries=3 --timeout=90 &

echo "Starting Reverb..."
php artisan reverb:start --host=0.0.0.0 --port=$PORT &

echo "Starting nginx/php-fpm..."
exec /usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf