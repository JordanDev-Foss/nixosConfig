{ inputs, config, pkgs, ... }:

{
  # Global SOPS-Nix Cryptographic Engine Configuration
  sops = {
    # Relative path from this file to your encrypted secrets file
    defaultSopsFile = ../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # Standard location for the age decryption private key file on the host machine
    age.keyFile = "/var/lib/sops-nix/key.txt";

    # Explicitly register the secret attribute the evaluator is searching for
    secrets.my_user_password = {
      # CRITICAL: Forces sops-nix to decrypt the password hash *before* user activation
      # loops execute, preventing a dependency race condition during early boot phases.
      neededForUsers = true;
    };
  };

  # Home Manager global backups
  home-manager.backupFileExtension = ".bak";

  # Automatic Upgrades (Handled cleanly via Flakes)
  system = {
    autoUpgrade = {
      enable = true;
      dates = "daily";
      flake = inputs.self.outPath;
      runGarbageCollection = false; # Disabled here; handled properly below
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
  # Do not change this value, even if upgrading NixOS releases.
  system.stateVersion = "25.05";
}
