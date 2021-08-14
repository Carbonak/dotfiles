#!/usr/bin/env bash

# Kill all current instances of polybar
killall polybar

# Wait until the porcesses have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done 

# Launch Polybar
polybar main -c $(dirname $0)/config.ini & 
