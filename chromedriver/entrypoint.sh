#!/bin/bash
set -ue -o pipefail

rm -f /tmp/.X0-lock
if [[ "$XVFB_SCREENSIZE" =~ ^[[:digit:]]{1,}x[[:digit:]]{1,}x(8|16|24)$ ]]; then
  sed -i "s/1280x800x24/$XVFB_SCREENSIZE/" /etc/supervisor/conf.d/supervisord.conf
fi

exec "$@"
