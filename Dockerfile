FROM php:8.2-apache

WORKDIR /var/www/html

# Runtime dependencies
RUN apt-get update && apt-get install -y --no-install-recommends libonig-dev \
    && rm -rf /var/lib/apt/lists/*

# PHP extensions runtime
RUN docker-php-ext-install -j$(nproc) pdo pdo_mysql mbstring

# Enable Apache modules
RUN a2enmod rewrite

# Set ServerName để xóa cảnh báo
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

# CMD chạy Apache foreground
CMD ["apache2-foreground"]
