{ pkgs, ... }:
{
	# Allow unfree packages
	nixpkgs.config.allowUnfree = true;
	fonts.packages = with pkgs; [
		corefonts
		vista-fonts
	];

	environment.systemPackages = with pkgs; [
		cmake
		ffmpeg-full
		git
		#gnome-boxes
		gnupg
		#libvirt
		neovim
		ollama-vulkan
		#virt-viewer
		wimlib
		wget
		qemu
		mesa
		mesa-gl-headers
		libva
		libva-utils
	];
	hardware.graphics.enable = true;
	hardware.bluetooth.enable = true;
	hardware.enableAllFirmware = true;
	hardware.graphics.extraPackages = with pkgs; [ 
		rocmPackages.clr.icd
		rocmPackages.tensile
	];

	environment.plasma6.excludePackages = with pkgs.kdePackages; [
		plasma-browser-integration
		konsole
		elisa
	];
	#virtualisation.libvirtd.enable = true;
}
