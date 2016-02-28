#!/bin/bash
set -ue -o pipefail

sed -i "s/^server_ip.*/server_ip $(/sbin/ip route|awk '/default/ {print $3}')/" /etc/pandora/pandora_agent.conf

# workaround for packaging problem
mkdir -p /var/log/pandora

exec "$@"
