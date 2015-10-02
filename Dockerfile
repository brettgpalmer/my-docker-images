FROM php:5.6-apache

#9/20/2015 BGP Add to increase upload limit
RUN touch /usr/local/etc/php/conf.d/upload-limit.ini && echo "upload_max_filesize = 32M" >> /usr/local/etc/php/conf.d/upload-limit.ini && echo "post_max_size = 32M" >> /usr/local/etc/php/conf.d/upload-limit.ini

#9/20/2015 BGP add mod rewrite to enable modules in Apache2
#RUN a2enmod rewrite
RUN a2enmod rewrite expires headers


# install the PHP extensions we need
#10/1/2015 BGP add the unzip to download to wp package
RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev unzip rsync && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd
RUN docker-php-ext-install mysqli

VOLUME /var/www/html

ENV WORDPRESS_VERSION 4.3.1
ENV WORDPRESS_SHA1 b2e5652a6d2333cabe7b37459362a3e5b8b66221

# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
RUN curl -o wordpress.tar.gz -SL https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
	&& echo "$WORDPRESS_SHA1 *wordpress.tar.gz" | sha1sum -c - \
	&& tar -xzf wordpress.tar.gz -C /usr/src/ \
	&& rm wordpress.tar.gz \
	&& chown -R www-data:www-data /usr/src/wordpress

COPY docker-entrypoint.sh /entrypoint.sh

# grr, ENTRYPOINT resets CMD now
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2-foreground"]
