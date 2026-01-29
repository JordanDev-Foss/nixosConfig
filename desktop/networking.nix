{ ... }:
{
	time.timeZone = "America/Chicago";
	networking = {
		hostName = "NixOS";
		networkmanager.enable = true;
		#nameservers = [ "10.100.0.195" ];
		interfaces.enp6s0.wakeOnLan.enable = true;

		# Configure network proxy if necessary
		#proxy.default = "http://192.168.49.1:8228/";
		#proxy.noProxy = "127.0.0.1,localhost,internal.domain";

		firewall = {
			enable = true;
			allowPing = false;
			allowedTCPPorts = [];
			allowedTCPPortRanges = [];
			allowedUDPPorts = [];
			allowedUDPPortRanges = [];
		};
	};
}
