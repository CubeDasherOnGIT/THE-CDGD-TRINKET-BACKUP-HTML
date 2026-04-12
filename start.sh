#!/bin/bash
set -e

MONGODB_DATA=/tmp/mongodb-data
MONGODB_LOG=/tmp/mongodb.log

mkdir -p $MONGODB_DATA

if [ -f "$MONGODB_DATA/mongod.lock" ]; then
  LOCK_PID=$(cat "$MONGODB_DATA/mongod.lock" 2>/dev/null || echo "")
  if [ -n "$LOCK_PID" ] && ! kill -0 "$LOCK_PID" 2>/dev/null; then
    echo "Removing stale MongoDB lock file"
    rm -f "$MONGODB_DATA/mongod.lock"
  fi
fi

if ! pgrep -x mongod > /dev/null 2>&1; then
  echo "Starting MongoDB..."
  mongod --dbpath $MONGODB_DATA --bind_ip 127.0.0.1 --port 27017 --logpath $MONGODB_LOG --fork
  sleep 2
  echo "MongoDB started"
else
  echo "MongoDB already running"
fi

echo "Starting Trinket app..."
exec node app.js
