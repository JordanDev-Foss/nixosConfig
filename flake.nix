{
  description = "Desktop Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixcord.url = "github:FlameFlag/nixcord";
    home-manager = {
    	url = "github:nix-community/home-manager/master";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
	url = "github:nix-community/lanzaboote/master";
	inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs@{ self, nixpkgs, home-manager, nixcord, lanzaboote, ... }: {
    nixosConfigurations.NixOS = nixpkgs.lib.nixosSystem rec {
    system = "x86_64-linux";
    specialArgs = {
	inherit inputs system;
    };
      modules = [
        ./boot.nix
        ./configuration.nix
        ./networking.nix
        ./packages.nix
        ./programs.nix
        ./services.nix
        ./users.nix
	/etc/nixos/hardware-configuration.nix
	home-manager.nixosModules.home-manager
	{
		home-manager.useGlobalPkgs = true;
		home-manager.useUserPackages = true;

		home-manager.users.dixonj = ./home.nix;
		home-manager.extraSpecialArgs = {
			inherit inputs;
		};
	}
	inputs.lanzaboote.nixosModules.lanzaboote

      	];
      };

    };
}
