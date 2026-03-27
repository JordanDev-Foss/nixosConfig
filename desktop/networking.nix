{ ... }:
{
	time.timeZone = "America/Chicago";
	networking = {
		hostName = "NixOS";
		networkmanager.enable = true;
		nameservers = [ "10.100.0.195" ];
		interfaces.enp6s0.wakeOnLan.enable = true;


		# Configure network proxy if necessary
		#proxy.default = "http://192.168.49.1:8228/";
		#proxy.noProxy = "127.0.0.1,localhost,internal.domain";

		firewall = {
			enable = true;
			allowPing = true;
			allowedTCPPorts = [ 39981 27015 27036 ];
			allowedTCPPortRanges = [ 
			{ from = 1714; to = 1764; }
			];
			allowedUDPPorts = [ 39981 27015 ];
			allowedUDPPortRanges = [
				{ from = 1714; to = 1764; }
				{ from = 27031; to = 27036; }
			];
		};
	};
}
