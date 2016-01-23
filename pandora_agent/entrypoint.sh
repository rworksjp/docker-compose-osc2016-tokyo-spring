#!/bin/bash
set -e

mkdir -p /var/log/pandora
sed -i "s/^server_ip.*/server_ip $(/sbin/ip route|awk '/default/ {print $3}')/" /etc/pandora/pandora_agent.conf

exec "$@"
