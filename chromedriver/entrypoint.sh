#!/bin/bash
set -e

rm -f /tmp/.X0-lock
x11vnc -storepasswd "$X11VNC_PASSWORD" /etc/x11vnc.pass

exec "$@"
