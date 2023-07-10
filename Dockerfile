# Specify the base image
FROM php:8.1-apache

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    curl \
    libicu-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install intl zip mysqli

# Set the working directory inside the container
WORKDIR /var/www/html

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    libicu-dev \
    libzip-dev \
    unzip \
    git \
    && docker-php-ext-install intl zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install Symfony CLI
RUN curl -sS https://get.symfony.com/cli/installer | bash \
    && export PATH="$HOME/.symfony/bin:$PATH"

# Copy your project files into the container
COPY . .

# Install project dependencies
RUN composer install --prefer-dist --no-progress --no-scripts --no-suggest --no-interaction

# Set up phpMyAdmin
ARG PMA_VERSION=5.1.1
RUN apt-get install -y wget \
    && wget https://files.phpmyadmin.net/phpMyAdmin/${PMA_VERSION}/phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz \
    && tar xvfz phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz \
    && mv phpMyAdmin-${PMA_VERSION}-all-languages phpmyadmin \
    && rm phpMyAdmin-${PMA_VERSION}-all-languages.tar.gz

# Configure Apache for phpMyAdmin
RUN echo "Alias /phpmyadmin /var/www/html/phpmyadmin" >> /etc/apache2/apache2.conf \
    && echo "<Directory /var/www/html/phpmyadmin>" >> /etc/apache2/apache2.conf \
    && echo "    Options Indexes FollowSymLinks" >> /etc/apache2/apache2.conf \
    && echo "    AllowOverride All" >> /etc/apache2/apache2.conf \
    && echo "    Require all granted" >> /etc/apache2/apache2.conf \
    && echo "</Directory>" >> /etc/apache2/apache2.conf

# Update Apache document root
RUN sed -i 's|/var/www/html|/var/www/html/public|g' /etc/apache2/sites-available/000-default.conf


# Expose port 8000 for Apache
EXPOSE 8000

# Start the Apache web server
CMD ["apache2ctl", "-D", "FOREGROUND"]
