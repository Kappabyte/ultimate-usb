{ lib, inputs, pkgs, user, home-manager, ... }: let
settings = ''
monitor=eDP-1,2736x1824,0x0,2
'';
in {
    imports = [
        (import ../../common/config/hyprland {system-settings = settings;})
    ];
}
