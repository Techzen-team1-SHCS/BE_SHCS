FROM richarvey/nginx-php-fpm:3.1.6

# copy project vào container
COPY . /var/www/html

WORKDIR /var/www/html

# cấp quyền chạy script
RUN chmod +x /var/www/html/start.sh

# Image config
ENV SKIP_COMPOSER 1
ENV WEBROOT /var/www/html/public
ENV PHP_ERRORS_STDERR 1
ENV RUN_SCRIPTS 1
ENV REAL_IP_HEADER 1

# Laravel config
ENV APP_ENV production
ENV APP_DEBUG false
ENV LOG_CHANNEL stderr

# Allow composer to run as root
ENV COMPOSER_ALLOW_SUPERUSER 1

# start container
CMD ["/var/www/html/start.sh"]