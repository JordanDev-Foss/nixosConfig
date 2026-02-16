{ pkgs, ... }:
{

	systemd.services.clearZshHistory = {
		description = "Clear Zsh History";
		script = ''
		#!/usr/bin/env zsh
		: > /home/dixonj/.config/zsh/.zsh_history
		'';
		serviceConfig = {
			PrivateNetwork = "yes";
			Type = "oneshot";
			User = "piadmin";
		};
	};
	systemd.timers.clearZshHistory = {
		description = "Timer to clear zsh history every 24 hours";
		timerConfig = {
			OnCalendar = "daily";
			Persistent = true;
			Unit = "clearZshHistory.service";
		};
		wantedBy = [ "timers.target" ];
	};


	systemd.settings.Manager = {
		DefaultTimeoutStopSec = "10s";
	};


	services = {
		ntfy-sh = {
			enable = true;
			settings = {
				base-url = "http://localhost";
				listen-http = ":904";
			};
		};
		unbound = {
			enable = true;
			settings = {
				server = {
					interface = [ "127.0.0.1" ];
					port = 5335;
					access-control = [ "127.0.0.1 allow" ];
					harden-glue = true;
					harden-dnssec-stripped = true;
					use-caps-for-id = false;
					prefetch = true;
					edns-buffer-size = 1232;
					num-threads = 1;
					hide-identity = true;
					hide-version = true;
				};
			};
		};
		pihole-ftl = {
			enable = true;
			lists = [
			{
				url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/main/lists/all_domains.txt";
				type = "block";
				enabled = true;
			}
			{
				url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
				type = "block";
				enabled = true;
			}];
			openFirewallDNS = true;
			openFirewallWebserver = true;
			queryLogDeleter.enable = true;
			settings = {
				dns = {
					domain = "jrips.org";
					domainNeeded = true;
					expandHosts = true;
					interface = "eth0";
					hosts = [
						"10.100.0.1	gateway"
						"10.100.0.195	pi"
						"10.100.0.174	printer"
					];
					upstreams = [ "127.0.0.1:5335" ];
				};
				ntp = {
					ipv4.active = false;
					ipv6.active = false;
					sync.active = false;
				};
				webserver = {
					api = {
						pwhash = "";
					};
					session = {
						timeout = 43200;
					};
				};
			};
		};

	};
}
