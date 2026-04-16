FROM php:8.2-fpm-alpine AS base

WORKDIR /var/www/html

RUN apk add --no-cache \
    git \
    curl \
    unzip \
    zip \
    oniguruma-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    libzip-dev \
    bash \
    icu-dev \
    $PHPIZE_DEPS \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl opcache \
    && rm -rf /var/cache/apk/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY composer.json composer.lock* ./
RUN composer install --no-interaction --prefer-dist --no-dev --optimize-autoloader --no-scripts || true

FROM base AS app
COPY . .
RUN composer install --no-interaction --prefer-dist --no-dev --optimize-autoloader
RUN chown -R www-data:www-data /var/www/html

EXPOSE 9000
CMD ["php-fpm", "-F"]
