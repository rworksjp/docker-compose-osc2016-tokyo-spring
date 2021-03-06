#!/bin/bash
set -ue -o pipefail

sed -i "s/^dbhost.*/dbhost mysql/" /etc/pandora/pandora_server.conf
sed -i "s/^dbuser.*/dbuser $MYSQL_PANDORA_USER/" /etc/pandora/pandora_server.conf
sed -i "s/^dbpass.*/dbpass $MYSQL_PANDORA_PASSWORD/" /etc/pandora/pandora_server.conf

chmod +x /opt/selenese/selenese-runner
/usr/bin/perl /register.pl

exec "$@"
