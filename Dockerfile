FROM php:7.1.10-apache

# PHP Core Extensions
RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Extensions bcmath
RUN docker-php-ext-configure bcmath \
    && docker-php-ext-install -j$(nproc) bcmath

# Extensions calendar
RUN docker-php-ext-configure calendar \
    && docker-php-ext-install -j$(nproc) calendar

# Extensions exif
RUN docker-php-ext-configure exif \
    && docker-php-ext-install -j$(nproc) exif

# Extensions mbstring
RUN docker-php-ext-configure mbstring \
    && docker-php-ext-install -j$(nproc) mbstring

# Extensions pdo
RUN docker-php-ext-configure pdo \
    && docker-php-ext-install -j$(nproc) pdo

# Extensions pdo_mysql
RUN docker-php-ext-configure pdo_mysql \
    && docker-php-ext-install -j$(nproc) pdo_mysql

# Extensions mysqli
RUN docker-php-ext-configure mysqli \
    && docker-php-ext-install -j$(nproc) mysqli

# Extensions zip
RUN apt-get update \
    && apt-get install -y --no-install-recommends zlib1g-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-install -j$(nproc) zip

# Extensions intl
RUN apt-get update \
    && apt-get install -y --no-install-recommends zlib1g-dev libicu-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl

# Extensions xml
RUN apt-get update \
    && apt-get install -y --no-install-recommends libxml2-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-install -j$(nproc) xml

RUN a2enmod rewrite

# Install utils
RUN apt-get update \
    && apt-get install -y nano git mysql-client wget\
    && rm -r /var/lib/apt/lists/*

# Install composer
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && chmod +x /usr/local/bin/composer

# Other settings
VOLUME /var/www/html

WORKDIR /var/www/html



