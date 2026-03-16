FROM richarvey/nginx-php-fpm:3.1.6

COPY . /var/www/html
WORKDIR /var/www/html

# Install extension needed for Reverb
RUN docker-php-ext-install pcntl

# Make start script executable
RUN chmod +x /var/www/html/start.sh

# Image config
ENV SKIP_COMPOSER=1
ENV WEBROOT=/var/www/html/public
ENV PHP_ERRORS_STDERR=1
ENV RUN_SCRIPTS=1
ENV REAL_IP_HEADER=1

# Laravel config
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV LOG_CHANNEL=stderr

ENV COMPOSER_ALLOW_SUPERUSER=1

CMD ["/start.sh"]
