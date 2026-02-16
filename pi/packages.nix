{ pkgs, ... }:
{
	# Allow unfree packages
	#nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		git
	];
	hardware.enableAllFirmware = true;

}
