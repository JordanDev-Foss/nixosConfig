{ config, pkgs, ... }:

{
  # Security and Certificate Management
  security.pam.services.kdewallet.kwallet.enable = true;
  security.pki.certificateFiles = [
    ./ca.pem # Points to your local CA certificate file
  ];

  # Virtualization & Container Subsystems
  virtualisation = {
    docker.enable = true;

    libvirtd = {
      enable = true;
      qemu = {
        # Removed deprecated 'runAsRoot = true' to isolate guest VMs from host root access
        swtpm.enable = true; # Enables Virtual TPM (Essential for secure guests like Windows 11)
      };
    };

    spiceUSBRedirection.enable = true; # Allows seamless USB pass-through from host to guest VMs
  };

  # Core Programs & Performance Optimization Profiles
  programs = {
    dconf.enable = true; # Necessary for preserving configuration states in GTK/Gnome/Virt-manager apps
    zsh.enable = true;
    gamemode.enable = true; # Optimizes CPU governor, GPU clocks, and process priority when gaming

    # Open Broadcaster Software (OBS)
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        obs-backgroundremoval # High-performance virtual green screen plugin
      ];
    };

    # Steam Environment & Firewall Hole-Punching
    steam = {
      enable = true;
      dedicatedServer.openFirewall = true; # Opens inbound network ports for Source Dedicated Servers
      # remotePlay.openFirewall = true;
      # localNetworkGameTransfers.openFirewall = true;
    };

    # GnuPG Cryptographic Agent Configuration
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true; # Maps GPG keys to handle your SSH authentication loops securely
      pinentryPackage = pkgs.pinentry-all; # Explicit variable reference, avoids structural ambiguity
    };

    # Graphical Interface for QEMU/KVM Virtual Machines
    # (Note: Handled cleanly here. Ensure your user belongs to the 'libvirtd' group in users.nix!)
    virt-manager.enable = true;
  };
}
