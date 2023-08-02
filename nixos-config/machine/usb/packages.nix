{ config, pkgs, ... }: {
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    
    # System packages common to all machines
    environment.systemPackages = with pkgs; [
        firefox
        
        neofetch
        neovim
        tmux
        wget
        git
        gh
        grc

        kitty

        wofi

        sddm-kcm
        
        xdg-user-dirs
        gnome.gnome-keyring
        papirus-folders
        catppuccin-cursors.mochaLight
    ];

    # Force electron applications to use wayland
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    fonts.fonts = with pkgs; [
        noto-fonts
        noto-fonts-emoji
        font-awesome
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];
}
