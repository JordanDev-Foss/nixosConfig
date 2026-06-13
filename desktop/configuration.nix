{ inputs, config, pkgs, ... }:

{
  # Global SOPS-Nix Cryptographic Engine Configuration
  sops = {
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets = {
      my_user_password = {
        neededForUsers = true;
      };

      # 1. Tell sops-nix to decrypt and map your GitHub private key
      github_private_key = {
        path = "/home/dixonj/.ssh/id_github";
        owner = "dixonj";
        group = "users";
        mode = "0600";
      };

      # 2. Tell sops-nix to decrypt and map your standard RSA private key
      rsa_private_key = {
        path = "/home/dixonj/.ssh/id_rsa";
        owner = "dixonj";
        group = "users";
        mode = "0600";
      };
    };
  };

  # 3. Keep your system SSH client cleanly configured to accept GitHub automatically
  programs.ssh = {
    knownHosts = {
      "github.com" = {
        publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl";
      };
    };
  };

  # =========================================================================
  # Rest of your file remains completely untouched below:
  # =========================================================================

  # Home Manager global backups
  home-manager.backupFileExtension = ".bak";

  # Automatic Upgrades (Handled cleanly via Flakes)
  system = {
    autoUpgrade = {
      enable = true;
      dates = "daily";
      flake = inputs.self.outPath;
      runGarbageCollection = false;
    };
  };

  # Nix Package Manager Configuration
  nix = {
    # Automatic Cleanup
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 10d";
    };

    # Nix Store Optimizations
    settings = {
      auto-optimise-store = true;
      download-buffer-size = "512M";
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # System State Version
  system.stateVersion = "25.05";
}
