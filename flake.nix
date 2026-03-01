{
  description = "Desktop Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
    	url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
	url = "github:nix-community/lanzaboote/master";
	inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, lanzaboote, ... }: {
    nixosConfigurations.Pi = nixpkgs.lib.nixosSystem rec {
      system = "aarch64-linux";
      specialArgs = {
      	inherit inputs system;
      };
      modules = [
        ./pi/boot.nix
	./pi/configuration.nix
	./pi/networking.nix
	./pi/packages.nix
	./pi/programs.nix
	./pi/services.nix
	./pi/users.nix
	./pi/hardware-configuration.nix
	"${nixpkgs}/nixos/modules/installer/sd-card/sd-image-raspberrypi.nix"
        {
          nixpkgs.config.allowUnsupportedSystem = true;
          nixpkgs.hostPlatform.system = "armv7l-linux";
          nixpkgs.buildPlatform.system = "x86_64-linux";
	}
	home-manager.nixosModules.home-manager
	{
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;
		home-manager.users.piadmin = ./pi/piadmin/home.nix;
		home-manager.extraSpecialArgs = {
			inherit inputs;
		};
	}
	inputs.lanzaboote.nixosModules.lanzaboote
      ];
    };

    nixosConfigurations.NixOS = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
	inherit inputs system;
    };
      modules = [
        ./desktop/boot.nix
        ./desktop/configuration.nix
        ./desktop/networking.nix
        ./desktop/packages.nix
        ./desktop/programs.nix
        ./desktop/services.nix
        ./desktop/users.nix
	./desktop/hardware-configuration.nix
	home-manager.nixosModules.home-manager
	{
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;

		home-manager.users.dixonj = ./desktop/dixonj/home.nix;
		home-manager.extraSpecialArgs = {
			inherit inputs;
		};
	}
	inputs.lanzaboote.nixosModules.lanzaboote

      	];
      };

    };

}
