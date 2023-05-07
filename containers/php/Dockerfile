FROM php:8.1-fpm

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y vim \
    && apt-get install -y curl ca-certificates zip dbus sqlite3 gnupg libcap2-bin libpng-dev libzip-dev zlib1g-dev libpq-dev \
    # Install php ext, dependencies
    && apt-get install -y default-mysql-client mariadb-client postgresql-client \
    && docker-php-ext-install opcache exif mysqli pdo_mysql pgsql pdo_pgsql zip pcntl sockets \
    # Install redis.
    && pecl install redis \
    && docker-php-ext-enable redis \
    # Install gd.
    && apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libpng-dev libjpeg-dev libonig-dev libcurl3-dev \
    && docker-php-ext-install -j$(nproc) gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html
