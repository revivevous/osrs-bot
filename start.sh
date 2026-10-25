#!/bin/bash
set -e

# 1. a fake screen, because there is no monitor
Xvfb :1 -screen 0 1024x768x16 -nolisten tcp &
sleep 3

# 2. the game client, wrapped so it restarts itself if it dies
while true; do
  java -Xmx300m -jar /app/microbot.jar || echo "client died, restarting"
  echo "restarting in 10 seconds"
  sleep 10
done &

# 3. so you can watch it from your phone browser
x11vnc -display :1 -forever -shared -nopw -rfbport 5900 &
websockify --web=/usr/share/novnc "${PORT:-10000}" localhost:5900 &

wait
