{ config, pkgs, ...}: {
    services.syncthing = {
        enable = true;
        user = "avery";
        dataDir = "/home/avery/documents";    # Default folder for new synced folders
        configDir = "/home/avery/.config/syncthing";   # Folder for Syncthing's settings and keys
    };
}
