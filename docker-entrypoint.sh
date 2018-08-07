#!/bin/bash

/usr/local/bin/wait-for-it.sh db:3306 -t 90 --

bundle exec rake db:migrate

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate. Running setup first."
  echo
  bundle exec rake db:setup
fi

# Execute the given or default command:
exec "$@"