{
  	description = "My Personal NixOS System Flake Configuration";

  	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = github:nix-community/home-manager;
			inputs.nixpkgs.follows = "nixpkgs";
		};

        nixos-hardware = {
            url = "github:NixOS/nixos-hardware/master";
        };
  	};

  	outputs = inputs @ { self, nixpkgs, home-manager, nixos-hardware, ... }:
	let
		user = "usb";
	in {
		nixosConfigurations = (
			import ./machine {
				inherit (nixpkgs) lib;
				inherit inputs nixpkgs user home-manager nixos-hardware;
			}
		);
	};
}
