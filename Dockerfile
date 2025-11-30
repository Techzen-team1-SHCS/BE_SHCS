# ===========================
# Stage 1: Builder
# ===========================
FROM php:8.2-apache AS builder

# Set working directory
WORKDIR /var/www/html

# Cài đặt các gói cần thiết để build PHP extensions + git, unzip, curl
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    curl \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libwebp-dev \
    libzip-dev \
    libonig-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Cấu hình và build PHP extensions một cách riêng biệt
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    --with-webp

RUN docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    gd

RUN docker-php-ext-install -j$(nproc) \
    zip \
    bcmath \
    ctype \
    fileinfo \
    json \
    mbstring \
    tokenizer \
    xml

# Cài Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Copy composer files và cài dependencies
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-interaction --prefer-dist

# Copy toàn bộ source code
COPY . .

# Tạo cache cho Laravel
RUN php artisan config:cache || true
RUN php artisan route:cache || true

# Cấp quyền cho Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html/storage \
    && chmod -R 755 /var/www/html/bootstrap/cache


# ===========================
# Stage 2: Runtime
# ===========================
FROM php:8.2-apache

WORKDIR /var/www/html

# Cài runtime dependencies (không cần dev tools)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libpng16-16 \
    libjpeg62-turbo \
    libfreetype6 \
    libwebp7 \
    libzip5 \
    libonig5 \
    zlib1g \
    && rm -rf /var/lib/apt/lists/*

# Cài đặt PHP extensions mà không cần cấu hình lại GD (đã built sẵn)
RUN docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    gd \
    zip \
    bcmath \
    ctype \
    fileinfo \
    json \
    mbstring \
    tokenizer \
    xml

# Bật Apache modules
RUN a2enmod rewrite headers

# Copy code từ builder
COPY --from=builder --chown=www-data:www-data /var/www/html /var/www/html

# Copy cấu hình Apache
COPY ./docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Tạo thư mục storage, cấp quyền
RUN mkdir -p /var/www/html/storage/logs \
    && mkdir -p /var/www/html/storage/app/public \
    && chown -R www-data:www-data /var/www/html/storage

# Configure PHP uploads
RUN echo "upload_max_filesize = 100M" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size = 100M" >> /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 80
CMD ["apache2-foreground"]
