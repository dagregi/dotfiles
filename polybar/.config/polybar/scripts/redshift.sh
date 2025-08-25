#!/bin/bash

# Redshift control script for polybar
# Usage: redshift.sh [increase|decrease|toggle|status]

red="$(awk '/\<color1\>/ {print $2}' ~/.config/X11/xresources)"
disabled="$(awk '/\<color8\>/ {print $2}' ~/.config/X11/xresources)"
primary="$(awk '/\<color3\>/ {print $2}' ~/.config/X11/xresources)"

MIN_TEMP=1000
MAX_TEMP=6500
STEP=300
DEFAULT_TEMP=4000
STATE_FILE="$HOME/.local/state/redshift_state"
PID_FILE="/tmp/redshift.pid"

ICON_ON=""
ICON_OFF=""

if [[ ! -f "$STATE_FILE" ]]; then
	echo "enabled:$DEFAULT_TEMP" >"$STATE_FILE"
fi

read_state() {
	if [[ -f "$STATE_FILE" ]]; then
		cat "$STATE_FILE"
	else
		echo "enabled:$DEFAULT_TEMP"
	fi
}

write_state() {
	echo "$1" >"$STATE_FILE"
}

is_redshift_running() {
	if [[ -f "$PID_FILE" ]]; then
		local pid=$(cat "$PID_FILE")
		if kill -0 "$pid" 2>/dev/null; then
			return 0
		else
			rm -f "$PID_FILE"
			return 1
		fi
	fi
	return 1
}

start_redshift() {
	local temp=$1
	redshift -m randr -O "$temp" >/dev/null 2>&1 &
	echo $! >"$PID_FILE"
}

stop_redshift() {
	if is_redshift_running; then
		local pid=$(cat "$PID_FILE")
		kill "$pid" 2>/dev/null
		rm -f "$PID_FILE"
	fi
	redshift -x >/dev/null 2>&1
}

apply_temperature() {
	local temp=$1
	stop_redshift
	start_redshift "$temp"
}

increase_temp() {
	local state=$(read_state)
	local status=$(echo "$state" | cut -d: -f1)
	local temp=$(echo "$state" | cut -d: -f2)

	if [[ "$status" == "enabled" ]]; then
		local new_temp=$((temp + STEP))
		if [[ $new_temp -gt $MAX_TEMP ]]; then
			new_temp=$MAX_TEMP
		fi
		write_state "enabled:$new_temp"
		apply_temperature "$new_temp"
	fi
}

decrease_temp() {
	local state=$(read_state)
	local status=$(echo "$state" | cut -d: -f1)
	local temp=$(echo "$state" | cut -d: -f2)

	if [[ "$status" == "enabled" ]]; then
		local new_temp=$((temp - STEP))
		if [[ $new_temp -lt $MIN_TEMP ]]; then
			new_temp=$MIN_TEMP
		fi
		write_state "enabled:$new_temp"
		apply_temperature "$new_temp"
	fi
}

toggle_redshift() {
	local state=$(read_state)
	local status=$(echo "$state" | cut -d: -f1)
	local temp=$(echo "$state" | cut -d: -f2)

	if [[ "$status" == "enabled" ]]; then
		write_state "disabled:$temp"
		stop_redshift
	else
		write_state "enabled:$temp"
		apply_temperature "$temp"
	fi
}

show_status() {
	local state=$(read_state)
	local status=$(echo "$state" | cut -d: -f1)
	local temp=$(echo "$state" | cut -d: -f2)

	if [[ "$status" == "enabled" ]]; then
		echo "%{F$primary}$ICON_ON%{F-} ${temp}K"
	else
		echo "%{F$red}$ICON_OFF%{F-} %{F$disabled}OFF%{F-}"
	fi
}

default() {
	local state=$(read_state)
	local status=$(echo "$state" | cut -d: -f1)
	local temp=$(echo "$state" | cut -d: -f2)

	if [[ "$status" == "enabled" ]]; then
		apply_temperature "$temp"
	else
		exit 0
	fi
}

case "$1" in
"increase" | "inc" | "+")
	increase_temp
	show_status
	;;
"decrease" | "dec" | "-")
	decrease_temp
	show_status
	;;
"toggle" | "t")
	toggle_redshift
	show_status
	;;
"status" | "s")
	show_status
	;;
"start")
	state=$(read_state)
	temp=$(echo "$state" | cut -d: -f2)
	write_state "enabled:$temp"
	apply_temperature "$temp"
	show_status
	;;
"stop")
	state=$(read_state)
	temp=$(echo "$state" | cut -d: -f2)
	write_state "disabled:$temp"
	stop_redshift
	show_status
	;;
"default")
	default
	show_status
	;;
*)
	echo "Usage: $0 [increase|decrease|toggle|status|info|start|stop]"
	echo ""
	echo "Commands:"
	echo "  increase, inc, +  - Increase temperature (less filtering)"
	echo "  decrease, dec, -  - Decrease temperature (more filtering)"
	echo "  toggle, t         - Toggle redshift on/off"
	echo "  status, s         - Show current status (for polybar)"
	echo "  start             - Start redshift"
	echo "  stop              - Stop redshift"
	echo ""
	echo "Temperature range: ${MIN_TEMP}K - ${MAX_TEMP}K"
	echo "Step size: ${STEP}K"
	exit 1
	;;
esac
