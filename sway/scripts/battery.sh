#!/usr/bin/env bash

while true 
do
	export DISPLAY=:0.0
	battery_percent=$(acpi -b | grep -P -o '[0-9]+(?=%)')
	if [ "$battery_percent" -gt 81 ]; then
		notify-send -i "$PWD/batteryfull.png" "Battery full." "Level: ${battery_percent}% "
	elif [ "$battery_percent" -lt 30 ]; then
		notify-send -i "$PWD/batteryfull.png" "Battery dead." "Level: ${battery_percent}% "
	fi

	sleep 120
done
