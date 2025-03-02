FROM debian

ARG GLPI_VERSION=10.0.18

# Update and upgrade the system, installing necessary packages
RUN apt update && \
    apt upgrade -y && \
    apt install lsb-release ca-certificates curl wget tar -y

# Add Sury repository for PHP
RUN curl -sSLo /tmp/debsuryorg-archive-keyring.deb https://packages.sury.org/debsuryorg-archive-keyring.deb && \
    dpkg -i /tmp/debsuryorg-archive-keyring.deb && \
    sh -c 'echo "deb [signed-by=/usr/share/keyrings/deb.sury.org-php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
    apt update

# Install PHP, PHP Modules and Apache2
RUN apt update && apt upgrade -y && \
apt install apache2 php8.3 php8.3-xml php8.3-mysql php8.3-ldap php8.3-xmlrpc \
            php8.3-imap php8.3-curl php8.3-gd php8.3-mbstring php8.3-xml php-cas \
            php8.3-intl php8.3-zip php8.3-bz2 php8.3-redis php8.3-bcmath cron jq libldap-2.5-0 \
            libldap-common libsasl2-2 libsasl2-modules libsasl2-modules-db -y

# Download and install GLPI
RUN wget "https://github.com/glpi-project/glpi/releases/download/${GLPI_VERSION}/glpi-${GLPI_VERSION}.tgz" -O /tmp/glpi.tgz && \
tar -xvzf /tmp/glpi.tgz -C /var/www/ && \
chown -R www-data:www-data /var/www/glpi && \
rm /tmp/glpi.tgz

EXPOSE 80

COPY ./virtualhost.conf /etc/apache2/sites-available/glpi.localhost.conf
RUN a2enmod rewrite && a2ensite glpi.localhost.conf && a2dissite 000-default.conf \
    && echo "session.cookie_httponly = 1" >> /etc/php/8.3/apache2/php.ini

ENTRYPOINT [ "/usr/sbin/apache2ctl", "-D", "FOREGROUND" ]



