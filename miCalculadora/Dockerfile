FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y apache2 dos2unix libcgi-pm-perl && \  
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN a2enmod cgi && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf
COPY html/ /var/www/html/
COPY css/ /var/www/html/css/
COPY cgi-bin/ /usr/lib/cgi-bin/
