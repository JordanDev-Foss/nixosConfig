{ ... }:
{
	time.timeZone = "America/Chicago";
	networking = {
		hostName = "Pihole";
		networkmanager.enable = true;
		nameservers = [ "10.100.0.195" ];

		# Configure network proxy if necessary
		#proxy.default = "http://192.168.49.1:8228/";
		#proxy.noProxy = "127.0.0.1,localhost,internal.domain";

		firewall = {
			enable = true;
			allowPing = true;
			allowedTCPPorts = [ 5335 22 904 53 ];
			allowedTCPPortRanges = [];
			allowedUDPPorts = [ 5335 53 ];
			allowedUDPPortRanges = [];
		};
	};
}
