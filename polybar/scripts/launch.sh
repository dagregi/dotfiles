#!/usr/bin/env sh

killall -q polybar

polybar main -l info -r >> ~/.tmp/polybar.log 2>&1 &
echo "Bar launched..."
