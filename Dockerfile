#Image de base: nginx (derniere MAJ)
FROM debian:latest

RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

#Adaptation du conteneur
RUN apt-get update \
    && apt install nginx php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-curl php-xml php-pear php-bcmath -y \
    && update-rc.d php7.3-fpm defaults

ADD ./default.conf /etc/nginx/sites-enabled/default
ADD ./index.php /var/www/html/

EXPOSE 80

CMD ["/bin/bash", "-c", "/usr/sbin/service php7.3-fpm start && nginx -g 'daemon off;'"]