{ pkgs, ... }:
{
	boot = {
		#binfmt.emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];
		lanzaboote = {
			enable = true;
			pkiBundle = "/var/lib/sbctl";
		};
		bootspec.enable = true;
		kernelPackages = pkgs.linuxPackages_xanmod;
		kernel.sysctl = {
			"vm.swappiness" = 10;
		};
		loader = {
			systemd-boot.editor = false;
			systemd-boot.enable = false;
			efi.canTouchEfiVariables = true;
		};
		kernelParams = [
			"quiet"
			"splash"
			"vga=current"
			"rd.systemd.show_status=false"
			"rd.udev.log_level=3"
			"udev.log_priority=3"
			"amd_iommu=on"
			"iommu=pt"
		];
		consoleLogLevel = 0;
		initrd.verbose = false;
	};
}
