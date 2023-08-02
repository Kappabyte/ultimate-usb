{ ... }: {
    xdg.configFile."hypr/hyprpaper.conf".text = ''
    preload = ~/.config/hypr/wallpaper.png
    wallpaper = ,~/.config/hypr/wallpaper.png
    splash = true
    '';

    xdg.configFile."hypr/wallpaper.png" = {
        source = ./wallpaper.png;
    };
}
