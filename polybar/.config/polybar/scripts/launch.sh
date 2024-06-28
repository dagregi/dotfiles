#!/usr/bin/env sh

pkill polybar
sleep 0.3
polybar main -r >/tmp/polybar.log 2>&1 &
echo "Bar launched..."
