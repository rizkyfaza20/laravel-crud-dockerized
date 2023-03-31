
# Use an official PHP runtime as a parent image
FROM php:7.3-cli

# Install required system packages
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install the MySQL Server package
ENV DB_HOST=db
ENV DB_PORT=3306
ENV DB_DATABASE=laravel
ENV DB_USERNAME=root
ENV DB_PASSWORD=root
RUN apt-get update && apt-get install -y default-mysql-server

# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql

# Set the working directory
WORKDIR /app
COPY . /app

# Install the required PHP dependencies using Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install --prefer-dist

# Set up Laravel environment variables
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV APP_KEY=base64:/f07BNX9YFQtpJjBq0VctIV0cEif+N7uJLb0k+WVr3o=
ENV APP_ENV=local
ENV APP_DEBUG=true
ENV DB_CONNECTION=mysql
ENV DB_HOST=db
ENV DB_PORT=3306
ENV DB_DATABASE=laravel
ENV DB_USERNAME=root
ENV DB_PASSWORD=root

# Expose the default Laravel port
EXPOSE 8000

# Start the Laravel development server
CMD php artisan serve --host=0.0.0.0 --port=8000
