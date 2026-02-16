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
			hashedPassword = "$y$j9T$s.FJzHljPctFdDdKrunCj.$HKFmChSvub2.sU5awC3FeUUx/nXWSdg50ednDX8/pe2";
			isNormalUser = lib.mkForce true;
			isSystemUser = lib.mkForce false;
			extraGroups = [ "wheel" ];
			shell = pkgs.zsh;
		};
	};
}
