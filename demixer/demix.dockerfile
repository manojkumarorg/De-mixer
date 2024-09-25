FROM php:7.4-fpm

# Set the working directory
WORKDIR /var/www

# Copy the composer.json file
COPY composer.json ./

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies
RUN composer install --no-dev --optimize-autoloader

# Copy the rest of your application files
COPY . .
