#!/usr/bin/env bash

killall polybar

# Wait until the porcesses have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done 

polybar main -c $(dirname $0)/config.ini & 
