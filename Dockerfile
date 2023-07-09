ROM php:8.1-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    libicu-dev \
    libzip-dev \
    unzip \
    git

# Enable Apache modules
RUN a2enmod rewrite

# Install PHP extensions
RUN docker-php-ext-install intl zip pdo_mysql

# Set the working directory
WORKDIR /var/www/html

# Copy the Symfony app files to the container
COPY . /var/www/html

# Set file permissions
RUN chown -R www-data:www-data /var/www/html

# Start Apache
CMD ["apache2-foreground"]