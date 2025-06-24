#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

ruby -v

# Ensure gems are installed
echo "Installing gems..."
bundle check || bundle install

# Wait for database to be ready
echo "Waiting for database..."
until bundle exec rails runner "ActiveRecord::Base.connection" > /dev/null 2>&1; do
  echo "Database is unavailable - sleeping"
  sleep 1
done

echo "Database is up - executing command"

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"