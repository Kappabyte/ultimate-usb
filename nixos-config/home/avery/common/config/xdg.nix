{ lib, inputs, pkgs, user, home-manager, ... }: {
    xdg.userDirs = {
        enable = true;
        createDirectories = true;
        documents = "/home/avery/documents";
        download = "/home/avery/downloads";
        music = "/home/avery/music";
        pictures = "/home/avery/pictures";
        videos = "/home/avery/vidoes";
        desktop = /home/avery/.desktopdir;
        publicShare = null;
        templates = null;
    };

    dconf.settings = {
        "org/cinnamon/desktop/applications/terminal" = {
            exec = "kitty";
        };
    };
}
