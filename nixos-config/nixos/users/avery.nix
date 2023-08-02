{ config, pkgs, ... }: {
    users.users.avery = {
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" ];
    };
}
