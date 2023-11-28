#!/data/data/com.termux/files/usr/bin/sh

killall -q polybar

polybar main -r >> ~/.tmp/polybar.log 2>&1 &
echo "Bar launched..."
