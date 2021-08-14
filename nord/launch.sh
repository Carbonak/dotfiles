#!/usr/bin/env bash

# Kill all current instances of polybar
killall polybar

# Wait until the porcesses have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done 

# Launch Polybar
#polybar main -c $(dirname $0)/config.ini & 

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload main -c $(dirname $0)/config.ini &
  done
else
  polybar --reload main -c $(dirname $0)/config.ini &
fi
