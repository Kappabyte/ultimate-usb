{ config, pkgs, ... }: {
    services.xserver.enable = true;
    hardware.opengl.enable = true;

   environment.sessionVariables.XAUTHORITY="\"$XDG_RUNTIME_DIR\"/Xauthority";
   environment.sessionVariables.XCOMPOSECACHE="\"$XDG_CACHE_HOME\"/X11/xcompose";

}
