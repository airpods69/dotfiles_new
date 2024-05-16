#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch mybar
echo "---" | tee -a /tmp/mybar.log
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar mybar -c ~/.config/polybar/config >>/tmp/mybar.log 2>&1 & disown
  done
else
  polybar --reload example &
fi
echo "Bar launched..."
