#!/bin/sh

set -e

/usr/local/bin/inject_envs.sh \
    /etc/rsyslogd.conf

exec "$@"