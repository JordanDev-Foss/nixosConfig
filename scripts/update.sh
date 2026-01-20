#!/usr/bin/env zsh
SECONDS=0
spinner() {
	local pid=$1
	local delay=0.1
	local spinstr='|/-\'
	while kill -0 $pid 2>/dev/null; do
		for i in $(seq 0 3); do
			printf "\r${spinstr:$i:1} Running..."
			sleep $delay
		done
	done
	printf "\r\033[KDone!\n"
}


printf "Updating Flatpaks...\n"
(flatpak update -y &>/dev/null) & spinner $!

printf "Updating Proton-GE...\n"
(protonup -y &>/dev/null) & spinner $!

printf "Updating Nix Flake...\n"
(nix flake update --flake $HOME/nix-flake &>/dev/null) & spinner $!

printf "Rebuilding NixOS...\n"
(sudo nixos-rebuild switch --flake $HOME/nix-flake --impure &>/dev/null) & spinner $!

printf "Finished Updating System.\n"
duration=$SECONDS
printf "Update Completed in: %02d minutes and %02d seconds\n" $((duration / 60)) $((duration % 60))
