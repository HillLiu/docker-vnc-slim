#!/bin/sh

server() {
  # bootstrap 
  chown app:app /data /dev/stdout && exec gosu app supervisord
}

if [ "$1" = 'server' ]; then
  server
else
  exec "$@"
fi
