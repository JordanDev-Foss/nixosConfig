{ pkgs, ... }:
{
	boot = {
		lanzaboote = {
			enable = true;
			pkiBundle = "/var/lib/sbctl";
		};
		bootspec.enable = true;
		kernelPackages = pkgs.linuxPackages_hardened;
		loader = {
			systemd-boot.editor = false;
			systemd-boot.enable = false;
			efi.canTouchEfiVariables = true;
		};
		kernelParams = [
			"quiet"
			"splash"
			"vga=current"
			"rd.systemd.show_status=true"
			"rd.udev.log_level=3"
			"udev.log_priority=3"
		];
		consoleLogLevel = 4;
		initrd.verbose = true;
	};
}
