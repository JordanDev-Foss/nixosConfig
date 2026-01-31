{ inputs, config, pkgs, lib, ... }: {

	home = {
		username = "dixonj";
		homeDirectory = "/home/dixonj";
		stateVersion = "25.11";
		enableNixpkgsReleaseCheck = false;
		packages = with pkgs; [
			bat
			bottom
			eza
			dysk
			fd
			fastfetch
			gimp
			inkscape
			kdePackages.kdeconnect-kde
			kdePackages.kleopatra
			#kdePackages.kdenlive
			keepassxc
			kitty
			librewolf
			libreoffice
			lutris
			nil
			nix-search
			onlyoffice-desktopeditors
			prismlauncher
			protonup-qt
			protonup-ng
			procs
			ripgrep
			rustdesk
			signal-desktop
			tealdeer
			tuigreet
			tree
			vlc
			vesktop
			vscodium
			wl-clipboard
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
			kitty = {
				enable = true;
				font.name = "FiraCode Nerd Font Mono";
				font.package = pkgs.nerd-fonts.fira-code;
				font.size = 16;
				shellIntegration.enableZshIntegration = true;
				themeFile = "CLRS";
				extraConfig = "background_image ~/nix-flake/assets/notebook.jpg\ninitial_window_width 1360\ninitial_window_height 1000\nremember_window_size no";
			};
	};

}
