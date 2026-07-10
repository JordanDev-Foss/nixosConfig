{ pkgs, ... }:

{
  # Global Systemd Manager Tweaks
  systemd.settings.Manager = {
    DefaultTimeoutStopSec = "10s"; # Prevents infinite system hangs from stubborn background daemons during reboots
  };

  # Custom Zsh History Purge Automation
  systemd.services.clearZshHistory = {
    description = "Clear Zsh History";
    script = ''
      #!/usr/bin/env zsh
      : > /home/dixonj/.config/zsh/.zsh_history
    '';
    serviceConfig = {
      PrivateNetwork = "yes";
      Type = "oneshot";
      User = "dixonj";
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

  # Core System, Networking, and Desktop Infrastructure
  services = {
    # Mesh VPN Configuration
    netbird.enable = true;

    # Log Maintenance
    journald.extraConfig = "SystemMaxUse=100M"; # Caps journal logs to 100MB to keep your Btrfs partition light

    # Display & Desktop Environments (Pure Wayland Focus)
    xserver.enable = false;
    xserver.videoDrivers = [ "amdgpu" ];
    desktopManager.plasma6.enable = true;
    displayManager.defaultSession = "plasma";

    # Graphical Login Manager (SDDM)
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      theme = "sddm-astronaut-theme"; # Handled alongside the asset package in packages.nix
    };

    # Flatpak Support
    flatpak.enable = true;

    # Audio Subsystem Pipeline (PipeWire handling PulseAudio applications seamlessly)
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      pulse.enable = true;
    };

    # Local Hardware & Printing Drivers
    libinput.enable = true;
    printing = {
      enable = true;
      webInterface = true; # Disables local unauthenticated browser management for network hardening
      drivers = [
      	pkgs.hplip
  	(pkgs.stdenv.mkDerivation {
    	name = "4barcode-driver";
    	src = ./4barcode-driver;
    	nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    	buildInputs = [ pkgs.stdenv.cc.cc.lib pkgs.cups ];
    	installPhase = ''
      	mkdir -p $out/lib/cups/filter
      	mkdir -p $out/share/cups/model
      	cp rastertosnailtspl-4barcode $out/lib/cups/filter/
      	cp 4B-2054N.ppd $out/share/cups/model/
	chmod +x $out/lib/cups/filter/rastertosnailtspl-4barcode
    	'';
  	})
	];

      openFirewall = false;
    };

    # Continuous Peer-to-Peer File Synchronization
    syncthing = {
      enable = true;
      openDefaultPorts = true; # Automatically punches the exact network holes needed in networking.nix
      guiAddress = "127.0.0.1:8384";
      user = "dixonj";
      dataDir = "/home/dixonj/Documents";
      configDir = "/home/dixonj/.config/syncthing";
    };
  };

  # XDG Portal Integration
  # Required backend for sandbox app communication (like flatpaks, screen sharing under Wayland)
  xdg.portal.enable = true;
}
