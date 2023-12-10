#!/usr/bin/env bash
languages=$(echo "rust typescript golang lua c python" | tr ' ' '\n')
core_utils=$(echo "awk sed xargs" | tr ' ' '\n')

selected=$(printf "$languages\n$core_utils" | fzf)
read -p "Enter Query: " query

printf $languages | grep -qs $selected && tmux neww bash -c "curl cht.sh/$selected/$(echo $query | tr ' ' '+') | less" ||
	tmux neww bash -c "curl cht.sh/$selected~$query | less"
