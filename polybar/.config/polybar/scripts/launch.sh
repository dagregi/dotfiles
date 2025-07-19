#!/usr/bin/env sh

pkill polybar
sleep 1
polybar main -r >/tmp/polybar.log 2>&1 &
if [ -n "$(xrandr -q | rg -w "HDMI2 connected")" ]; then
	polybar external -r >/tmp/polybar-ex.log 2>&1 &
fi
echo "Bar launched..."
