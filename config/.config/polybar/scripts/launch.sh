#!/usr/bin/env sh

pkill -9 polybar
polybar main -r >/tmp/polybar.log 2>&1 &
echo "Bar launched..."
