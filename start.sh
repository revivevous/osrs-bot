#!/bin/bash
set -e

# 1. a fake screen, because there is no monitor
Xvfb :1 -screen 0 1024x768x16 -nolisten tcp &
sleep 3

# 2. the game client
java -Xmx320m -jar /app/microbot.jar --no-splash &

# 3. so you can watch it from your phone browser
x11vnc -display :1 -forever -shared -nopw -rfbport 5900 &
websockify --web=/usr/share/novnc "${PORT:-10000}" localhost:5900 &

wait
