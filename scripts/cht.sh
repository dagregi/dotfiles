#!/usr/bin/env bash
languages=$(echo "rust typescript golang lua" | tr ' ' '\n')
core_utils=$(echo "awk fd sd rg xargs" | tr ' ' '\n')

selected=$(printf "$languages\n$core_utils" | fzf)
read -p "Enter Query: " query

if printf $languages | grep -qs $selected; then
	tmux neww bash -c "curl cht.sh/$selected/$(echo $query | tr ' ' '+') | less"
else
	tmux neww bash -c "curl cht.sh/$selected~$query | less"
fi
