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

COPY apache-config.conf /etc/apache2/conf-enabled/cgi-bin.conf

RUN find /usr/lib/cgi-bin/ -type f -name "*.pl" -exec dos2unix {} \; && \
    chmod +x /usr/lib/cgi-bin/*.pl

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["apache2ctl", "-D", "FOREGROUND"]