{
  description = "Jordan's Multi-Host Declarative NixOS Flake Layout";

  inputs = {
    # System Package Channels
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Declarative User Dotfile Management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # UEFI Secure Boot Compliance Layer
    lanzaboote = {
      url = "github:nix-community/lanzaboote"; # Tracks stable Secure Boot releases
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secure Git-Friendly Secret Handling
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote, sops-nix, ... }@inputs: {
    nixosConfigurations = {

      # 🖥️ DESKTOP ENVIRONMENT CONFIGURATION
      # Target Machine: x86_64 High-Performance Workstation/Gaming Node
      NixOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Native Ecosystem Infrastructure Modules
          lanzaboote.nixosModules.lanzaboote
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager

          # Split System Configuration Modules
          ./desktop/configuration.nix
          ./desktop/hardware-configuration.nix
          ./desktop/boot.nix
          ./desktop/networking.nix
          ./desktop/services.nix
          ./desktop/programs.nix
          ./desktop/packages.nix
          ./desktop/users.nix

          # Direct Injected Home Manager Environment
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dixonj = import ./desktop/dixonj/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

      # 🍓 RASPBERRY PI ENVIRONMENT CONFIGURATION
      # Target Machine: aarch64 (ARM64) Infrastructure Node
      Pi = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          # Injecting SOPS and Home Manager into the ARM runtime environment
          sops-nix.nixosModules.sops
          home-manager.nixosModules.home-manager

          # Dedicated Pi Hardware, Services, and Configuration Files
          ./pi/configuration.nix
          ./pi/hardware-configuration.nix
          ./pi/networking.nix
          ./pi/services.nix
          ./pi/users.nix

          # Pi-Specific Admin User Dotfile Space
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.piadmin = import ./pi/piadmin/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };

    };
  };
}
