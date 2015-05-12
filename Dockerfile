FROM busybox:latest
MAINTAINER Brett Palmer <brettgpalmer@gmail.com>
RUN mkdir /var/lib/mysql && mkdir /var/www/html
VOLUME ["/var/lib/mysql", "/var/www/html"]
