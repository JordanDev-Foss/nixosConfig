{ inputs, pkgs, lib, ... }: {
	imports = [ inputs.nixcord.homeModules.nixcord ];

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
			kdePackages.kdenlive
			keepassxc
			kitty
			librewolf
			libreoffice
			lutris
			nil
			nix-search
			oh-my-zsh
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
			vesktop
			vlc
			vscodium
			wl-clipboard
			wireshark-cli
			xh
			zsh
			];
		};

		

		programs = {
			nixcord = {
				enable = true;
				vesktop.enable = true;
				config = {
					useQuickCss = true;
					themeLinks = [
						"https://raw.githubusercontent.com/DiscordStyles/FrostedGlass/deploy/FrostedGlass.theme.css"
					];
					frameless = false;
					plugins = {
						BlurNSFW.enable = true;
						betterFolders.enable = true;
						alwaysAnimate.enable = true;
						ClearURLs.enable = true;
						copyStickerLinks.enable = true;
						crashHandler.enable = true;
						decor.enable = true;
						gameActivityToggle.enable = true;
						imageFilename.enable = true;
						replaceGoogleSearch = {
							enable = true;
							customEngineName = "DuckDuckGo";
							customEngineURL = "https://duckduckgo.com/search?q=";
						};
						USRBG.enable = true;
						webKeybinds.enable = true;
						webScreenShareFixes.enable = true;
						whoReacted.enable = true;
						youtubeAdblock.enable = true;
					};
				};
			};

			zsh = {
				enable = true;
				autocd = true;
				enableCompletion = true;
				autosuggestion.enable = true;

				initContent = ''
				cat ~/nix-flake/ascii.txt
				fastfetch -c examples/2.jsonc
				'';
				shellAliases = {
					gc = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
					ls = "eza --icons -hal";
					logout = "qdbus org.kde.Shutdown /Shutdown logout";
					poweroff = "qdbus org.kde.Shutdown /Shutdown logoutAndShutdown";
					reboot = "qdbus org.kde.Shutdown /Shutdown logoutAndReboot";
					cat = "bat";
					update = "$HOME/nix-flake/scripts/update.sh";
					speedtest = "xh --download http://speedtest.tele2.net/20MB.zip";
					rebuild = "sudo nixos-rebuild switch --flake /home/dixonj/nix-flake --impure --offline";
					find = "fd";
					grep = "rg";
					top = "btm";
					curl = "xh";
					df = "dysk -a";
					fastfetch = "cat $HOME/nix-flake/ascii.txt; fastfetch -c examples/2.jsonc";
					neofetch = "cat $HOME/nix-flake/ascii.txt; fastfetch -c examples/2.jsonc";

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
				font.size = 12;

			};
	};

}
