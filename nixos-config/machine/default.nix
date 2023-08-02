{ lib, inputs, nixpkgs, user, home-manager, nixos-hardware, ... }:

let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
    };

    lib = nixpkgs.lib;
in {
    usb = lib.nixosSystem {
        inherit system;
        specialArgs = {
            inherit inputs user system;
            host = {
                hostName = "usb";
            };
        };
        modules = [
            ./usb
            home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users = (import ../home/desktop.nix {
                    inherit lib inputs pkgs user home-manager;
                });
            }
        ];
    };
}
