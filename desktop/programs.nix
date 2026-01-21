{ pkgs, ... }:
{
	security.pam.services.kdewallet.kwallet.enable = true;
	virtualisation.docker.enable = true;
	programs = {
		zsh.enable = true;
		obs-studio = {
			enable = true;
			plugins = with pkgs.obs-studio-plugins; [
				obs-backgroundremoval
				];
			};
		steam = {
			enable = true;
			#remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
			dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
			#localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
		};
		gnupg.agent = {
			enable = true;
			pinentryPackage = with pkgs; pinentry-all;
			enableSSHSupport = true;
		};
	gamemode.enable = true;
	};

}
