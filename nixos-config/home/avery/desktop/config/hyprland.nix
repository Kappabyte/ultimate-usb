{ lib, inputs, pkgs, user, home-manager, ... }: let
settings = ''
monitor=HDMI-A-2, 2560x1080, 0x0, 1
monitor=HDMI-A-1, 1920x1080, 2560x0, 1

workspace = HDMI-A-2, 1
workspace = HDMI-A-1, 2

env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = GBM_BACKEND,nvidia-drm
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
'';
in {
    imports = [
        (import ../../common/config/hyprland {system-settings = settings;})
    ];
}
