#!/bin/sh

xsetroot -cursor_name left_ptr &
xrdb -merge $XDG_CONFIG_HOME/X11/.Xresources &

exec bspwm
