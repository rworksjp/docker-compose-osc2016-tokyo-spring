#!/bin/bash
set -e

rm -f /tmp/.X0-lock

exec "$@"
