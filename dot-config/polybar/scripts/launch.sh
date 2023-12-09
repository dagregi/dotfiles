#!/usr/bin/env bash

killall -q polybar

polybar main -r >/tmp/polybar.log 2>&1 &
echo "Bar launched..."
