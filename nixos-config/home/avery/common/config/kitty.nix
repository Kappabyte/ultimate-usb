{ lib, inputs, pkgs, user, home-manager, ... }: {
    programs.kitty = {
        enable = true;
        theme = "One Dark";
        font.name = "JetBrainsMono Nerd Font";
    };
}
