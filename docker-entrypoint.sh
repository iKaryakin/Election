#!/bin/bash

/usr/local/bin/wait-for-it.sh db:3306 -t 90 --

if [ -f /app/tmp/pids/server.pid ]; then
  echo "== Remove server.pid =="
  rm /app/tmp/pids/server.pid
fi

bundle exec rake db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  bundle exec rake db:setup && \
  bundle exec rake db:migrate
fi

# Execute the given or default command:
exec "$@"