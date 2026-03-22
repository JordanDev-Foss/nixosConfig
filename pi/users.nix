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
		piadmin = {
			hashedPasswordFile = "/etc/nixos/pi/piadmin/.secret";
			isNormalUser = lib.mkForce true;
			isSystemUser = lib.mkForce false;
			extraGroups = [ "wheel" ];
			shell = pkgs.zsh;
		};
	};
}
