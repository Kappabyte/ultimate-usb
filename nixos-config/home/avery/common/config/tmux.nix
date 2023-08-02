{ lib, inputs, pkgs, user, home-manager, ... }: {
    programs.tmux = {
        enable = true;
        mouse = true;
        prefix = "C-a";
        plugins = with pkgs; [
            tmuxPlugins.onedark-theme
        ];
        extraConfig = ''
            bind C-j display-popup -E "tms switch"
            bind C-o display-popup -E "tms"
        '';
    };
}
