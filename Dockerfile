# ===========================
# Stage 1: Builder
# ===========================
FROM php:8.2-apache AS builder

WORKDIR /var/www/html

# Cài đặt dependencies cơ bản
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    curl \
    libzip-dev \
    libonig-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

# Cài PHP extensions cần thiết
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    zip \
    mbstring \
    gd

# Cài Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Copy composer files và cài dependencies
COPY composer.json composer.lock ./
RUN composer install --no-dev --no-interaction --prefer-dist

# Copy toàn bộ source code
COPY . .

# Cấp quyền cho Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache


# ===========================
# Stage 2: Runtime
# ===========================
FROM php:8.2-apache

WORKDIR /var/www/html

# Cài runtime dependencies (chỉ cần libonig-dev, không cần libzip-dev)
RUN apt-get update && apt-get install -y --no-install-recommends \
    libonig-dev \
    && rm -rf /var/lib/apt/lists/*

# Cài PHP extensions cần thiết (zip đã cài ở builder)
RUN docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    mbstring

# Bật Apache modules
RUN a2enmod rewrite

# Copy code từ builder
COPY --from=builder --chown=www-data:www-data /var/www/html /var/www/html

# Copy cấu hình Apache
COPY ./docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Cấp quyền storage
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Configure PHP
RUN echo "upload_max_filesize = 100M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size = 100M" >> /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 80

CMD ["apache2-foreground"]
