{ config, pkgs, ... }:

{
  security = {
    sudo.enable = true;
  };

  # Prevent imperative user modifications (e.g., 'passwd' or 'useradd' commands)
  users.mutableUsers = false;

  users.users = {
    # Hardened Root Account
    root = {
      hashedPassword = "!";
      shell = "${pkgs.shadow}/bin/nologin"; # Completely disables logging directly into root
    };

    # Main User Account
    dixonj = {
      # Points directly to the secure, decrypted runtime path managed by sops-nix
      # No raw text passwords or unsafe local file paths in the Nix store!
      hashedPasswordFile = config.sops.secrets.my_user_password.path;

      isNormalUser = true;

      # Complete Group Assignments
      extraGroups = [
        "wheel"      # Sudo execution capabilities
        "ollama"     # Local AI model and hardware compute acceleration access
        "adbusers"   # Android Debug Bridge utility permissions
        "video"      # Raw hardware video acceleration controls
        "docker"     # Application virtualization and system container access
        "libvirtd"   # Complete Virtual Machine management via QEMU/KVM
        "kvm"        # Kernel-level hardware acceleration access for VMs
      ];

      shell = pkgs.zsh;
    };
  };
}
