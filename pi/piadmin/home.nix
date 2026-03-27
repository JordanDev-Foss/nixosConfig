{ inputs, config, pkgs, lib, ... }: {

	home = {
		username = "piadmin";
		homeDirectory = "/home/piadmin";
		stateVersion = "25.11";
		enableNixpkgsReleaseCheck = false;
		packages = with pkgs; [
			bat
			bottom
			eza
			dysk
			fd
			fastfetch
			nix-search
			procs
			ripgrep
			tuigreet
			tree
			wireshark-cli
			xh
			zsh
			];
		};
		
		programs = {
			home-manager.enable = true;
			zsh = {
				enable = true;
				autocd = true;
				enableCompletion = true;
				autosuggestion.enable = true;

				initContent = ''
				cat ~/nix-flake/scripts/ascii.txt
				fastfetch -c examples/2.jsonc
				'';
				shellAliases = {
					gc = "nix-collect-garbage -d; sudo nix-collect-garbage -d";
					ls = "eza --icons -hal";
					logout = "qdbus org.kde.Shutdown /Shutdown logout";
					poweroff = "qdbus org.kde.Shutdown /Shutdown logoutAndShutdown";
					reboot = "qdbus org.kde.Shutdown /Shutdown logoutAndReboot";
					cat = "bat";
					update = "$HOME/nix-flake/scripts/update.sh";
					speedtest = "xh --download http://speedtest.tele2.net/20MB.zip";
					rebuild = "sudo nixos-rebuild switch --impure --offline --flake /home/dixonj/nix-flake";
					find = "fd";
					grep = "rg";
					top = "btm";
					curl = "xh";
					df = "dysk -a";
					fastfetch = "cat $HOME/nix-flake/scripts/ascii.txt; fastfetch -c examples/2.jsonc";
					neofetch = "cat $HOME/nix-flake/scripts/ascii.txt; fastfetch -c examples/2.jsonc";

				};

				oh-my-zsh = {
					enable = true;
					plugins = [ "git" ];
					theme = "duellj";
				};
			};
			
			git = {
				enable = true;
				settings = {
					user.name = "JordanDev-Foss";
					user.email = "jordandixon@jrips.org";
					extraConfig = {
						init.defaultBranch = "master";
					};
				};

			};
	};

}
