#!/usr/bin/env bash

# Terminate already running bar instances
killall -q waybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch mybar
echo "---" | tee -a /tmp/mybar.log
  waybar &
echo "Bar launched..."
