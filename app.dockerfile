FROM php:7.2-fpm-alpine

# Copy the application code to the container
COPY ./demixer /var/www

# Set ownership for the copied files
RUN chown -R www-data:www-data /var/www

# Set working directory
WORKDIR /root

# Install Composer
RUN curl --silent --show-error https://getcomposer.org/installer | php
RUN ln -s ~/composer.phar /usr/bin/composer
RUN chmod +x ~/composer.phar

# Change to the app directory
WORKDIR /var/www

# Delete composer.lock file and vendor folder (if they exist)
RUN rm -f composer.lock
RUN rm -rf vendor/

# Install dependencies and create a new composer.lock
RUN composer install

# Update composer and regenerate autoload files
RUN composer update
RUN composer self-update --1

# Copy environment file and run your custom script
RUN cp .env.example .env
RUN sh refresh.sh

# Expose port 9000 for the PHP-FPM service
EXPOSE 9000

