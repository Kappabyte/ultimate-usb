{ config, pkgs, ... }: {
    services.xserver.enable = true;
    hardware.opengl.enable = true;

    services.xserver.displayManager.sddm.enable = true;
    services.xserver.displayManager.sddm.enableHidpi = true;
    services.xserver.displayManager.sddm.theme = "sugar-dark";

    environment.systemPackages = let themes = pkgs.callPackage ../../custom/packages/sddm-sugar-dark {}; in [
        pkgs.libsForQt5.qt5.qtquickcontrols2
        pkgs.libsForQt5.qt5.qtsvg
        pkgs.libsForQt5.qt5.qtgraphicaleffects
        themes.sddm-sugar-dark
    ];
}
