{ lib, inputs, pkgs, user, home-manager, ... }: {
    gtk = {
        enable = true;
        theme = {
            name = "One-Dark";
            package = (pkgs.callPackage ../../../../custom/packages/onedark-gtk/default.nix {}); 
        };
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme.override {
                color = "cyan";
            };
        };
        cursorTheme = {
            name = "Catppuccin-Mocha-Light-Cursors";
            size = 48;
        };
    };
}
