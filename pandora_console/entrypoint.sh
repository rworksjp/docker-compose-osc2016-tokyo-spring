#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
  set -- /usr/sbin/httpd -D FOREGROUND "$@"
fi

if [ "$(basename $1)" = 'httpd' ]; then
  mysql -u root -p$MYSQL_ROOT_PASSWORD -h mysql -e 'CREATE DATABASE IF NOT EXISTS `pandora`;'
  mysql -u root -p$MYSQL_ROOT_PASSWORD -h mysql -e "GRANT ALL PRIVILEGES ON \`pandora\`.* TO '$MYSQL_PANDORA_USER' IDENTIFIED BY '$MYSQL_PANDORA_PASSWORD';"
  mysql -u root -p$MYSQL_ROOT_PASSWORD -h mysql -e "FLUSH PRIVILEGES;"
  sed -i 's/CREATE TABLE t/CREATE TABLE IF NOT EXISTS t/g' /var/www/html/pandora_console/pandoradb.sql
  mysql -u root -p$MYSQL_ROOT_PASSWORD -h mysql -D pandora < /var/www/html/pandora_console/pandoradb.sql
  mysql -u root -p$MYSQL_ROOT_PASSWORD -h mysql -D pandora < /var/www/html/pandora_console/pandoradb_data.sql || :
  cat <<__EOF__ > /var/www/html/pandora_console/include/config.php
<?php
\$config["dbtype"]="mysql";
\$config["dbname"]="pandora";
\$config["dbuser"]="$MYSQL_PANDORA_USER";
\$config["dbpass"]="$MYSQL_PANDORA_PASSWORD";
\$config["dbhost"]="mysql";
\$config["homedir"]="/var/www/html/pandora_console";
\$config["homeurl"]="/pandora_console";
\$config["homeurl_static"]="/pandora_console";
error_reporting(E_ALL);
\$ownDir = dirname(__FILE__) . DIRECTORY_SEPARATOR;
include (\$ownDir . "config_process.php");
?>
__EOF__
  chown apache:apache /var/www/html/pandora_console/include/config.php
  chmod 600 /var/www/html/pandora_console/include/config.php
  if [ -e /var/www/html/pandora_console/install.php ]; then
    mv /var/www/html/pandora_console/install.php /var/www/html/pandora_console/install.php.done
    chmod 000 /var/www/html/pandora_console/install.php.done
  fi
fi

exec "$@"
