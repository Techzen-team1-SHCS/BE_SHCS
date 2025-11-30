# ===========================
# Stage 1: Builder
# ===========================
FROM php:8.2-apache AS builder

WORKDIR /var/www/html

# Cài đặt dependencies
RUN apt-get update && apt-get install -y git unzip curl libzip-dev libonig-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip \
    && rm -rf /var/lib/apt/lists/*

# Copy source code và composer install
COPY composer.json composer.lock ./
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --no-dev --no-interaction --prefer-dist

COPY . .

# Set quyền storage
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# ===========================
# Stage 2: Runtime
# ===========================
FROM php:8.2-apache

WORKDIR /var/www/html

# Runtime dependencies
RUN apt-get update && apt-get install -y libonig-dev && rm -rf /var/lib/apt/lists/*

# PHP extensions runtime
RUN docker-php-ext-install pdo pdo_mysql mbstring

# Enable Apache modules
RUN a2enmod rewrite
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Copy code từ builder
COPY --from=builder --chown=www-data:www-data /var/www/html /var/www/html

# Copy Apache vhost
COPY ./docker/vhost.conf /etc/apache2/sites-available/000-default.conf

# Permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Configure PHP upload
RUN echo "upload_max_filesize = 100M" >> /usr/local/etc/php/conf.d/uploads.ini && \
    echo "post_max_size = 100M" >> /usr/local/etc/php/conf.d/uploads.ini

EXPOSE 80

CMD ["apache2-foreground"]
