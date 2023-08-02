{ config, pkgs, ... }: {
    services.xserver.enable = true;
    hardware.opengl.enable = true;

    services.xserver.displayManager.gdm.enable = true;
}
