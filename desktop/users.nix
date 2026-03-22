{ lib, pkgs, ... }:

# This file is used for configuring users.
{
	security = {
		sudo.enable = true;
	};
	users.mutableUsers = false;
	users.users = {
		root = {
			hashedPassword = "!";
			shell = "/run/current-system/sw/bin/nologin";
		};
		dixonj = {
			hashedPasswordFile = "/etc/nixos/desktop/dixonj/.secret";
			isNormalUser = lib.mkForce true;
			isSystemUser = lib.mkForce false;
			extraGroups = [ "wheel" "ollama" "adbusers" "video" "docker" "libvirtd" "kvm" ];
			shell = pkgs.zsh;
		};
	};
}
