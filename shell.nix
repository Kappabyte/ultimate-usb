{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    # nativeBuildInputs is usually what you want -- tools you need to run
    nativeBuildInputs = [
        pkgs.nixos-install-tools
        pkgs.wget
        pkgs.ventoy-bin-full
        pkgs.p7zip
        pkgs.refind
    ];
}

