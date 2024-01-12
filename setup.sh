#!/bin/sh

show_progress() {
	local msg="$1"
	local color="$2"
	local pid=$3
	local delay=0.1
	local spin="-\|/"
	local count=0

	echo -n "\033[1;${color}m[$msg] \033[0m"
	while [ -d /proc/"$pid" ]; do
		local temp=${spin#?}
		printf " %c  " "$spin"
		local spin=$temp${spin%"$temp"}
		printf "\b\b\b\b"
		sleep $delay
	done
	printf "\b"
	echo " Done!"
}

install_dependencies() {
	xbps-install -y base-devel bubblewrap rust-sccache >/dev/null 2>&1 &
	show_progress "Installing dependencies" 34 $!
}
install_rust() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh &
	show_progress "Installing Rust" 34 $!
	rustup component add rustfmt rust-analyzer clippy >/dev/null 2>&1 &
	show_progress "\tAdding Rust tools" 35 $!
	rustup target add wasm32-unknown-unknown >/dev/null 2>&1 &
	show_progress "\tAdding Rust targets" 35 $!
	rustup completions zsh >/usr/share/zsh/functions/Completion/Linux/_rustup && rustup completions zsh cargo >/usr/share/zsh/functions/Completion/Linux/_cargo >/dev/null 2>&1 &
	show_progress "\tSetting up Rust completions" 35 $!
}
install_go() {
	xbps-install -y go >/dev/null 2>&1 &
	show_progress "Installing Go" 34 $!
}
install_node() {
	xbps-install -y nodejs nodejs-devel >/dev/null 2>&1 &
	show_progress "Installing NodeJs" 34 $!
	npm install -g npm >/dev/null 2>&1 &
	show_progress "\tInstalling npm" 35 $!
}
install_postgresql() {
	xbps-install -y postgresql15 postgresql15-client postgresql-libs >/dev/null 2>&1 &
	show_progress "Installing PostgreSQL" 34 $!
	sudo -u postgres initdb -D /var/lib/postgres/data >/dev/null 2>&1 &
	show_progress "\tInitializing PostgreSQL" 35 $!
}

read -p "Do you want to setup developmental environment? [y/N] " choice
case "$choice" in
y | Y) {
	mkdir -p projects/rust projects/go projects/ocaml projects/haskell
	install_dependencies
	install_node
	install_go
	install_postgresql
	install_rust
} ;;
*) echo "Skipping setup" ;;
esac
