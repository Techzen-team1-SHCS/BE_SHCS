# Dùng PHP + Apache
FROM php:8.2-apache

# Cài các thư viện cần thiết cho Laravel
RUN apt-get update && apt-get install -y \
    git zip unzip libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql gd

# Cài Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Làm việc trong thư mục dự án
WORKDIR /var/www/html

# Copy toàn bộ code vào container
COPY . .

# Cấp quyền cho Laravel
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Bật mod_rewrite cho Apache
RUN a2enmod rewrite

# Copy file cấu hình Apache
COPY ./docker/vhost.conf /etc/apache2/sites-available/000-default.conf

EXPOSE 80

CMD ["apache2-foreground"]
