#!/bin/sh

# set -e causes a script immediatly exits when it encounters an error
set -e

envsubst < /var/www/index.html.template > /var/www/index.html && \
exec "$@"
