{
  description = "Desktop Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
