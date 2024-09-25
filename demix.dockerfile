# Use an official PHP image with FPM (FastCGI Process Manager)
FROM php:7.4-fpm

# Set working directory
WORKDIR /var/www

# Install necessary packages and PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    libonig-dev \
    && docker-php-ext-install zip pdo pdo_mysql openssl \
    && rm -rf /var/lib/apt/lists/*  # Clean up APT when done.

# Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy composer files and install dependencies
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# Copy the rest of your application
COPY . .

# Expose port for PHP-FPM
EXPOSE 9000

# Command to run PHP-FPM
CMD ["php-fpm"]
# Use an official PHP image with FPM (FastCGI Process Manager)
FROM php:7.4-fpm

# Set working directory
WORKDIR /var/www

# Install necessary packages and PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev \
    unzip \
    git \
    libonig-dev \
    && docker-php-ext-install zip pdo pdo_mysql openssl \
    && rm -rf /var/lib/apt/lists/*  # Clean up APT when done.

# Install Composer globally
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy composer files and install dependencies
COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader

# Copy the rest of your application
COPY . .

# Expose port for PHP-FPM
EXPOSE 9000

# Command to run PHP-FPM
CMD ["php-fpm"]
