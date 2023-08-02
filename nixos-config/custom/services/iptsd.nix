{ config, lib, pkgs, ... }:

let
    inherit (lib) mkDefault mkEnableOption mkIf mkMerge;

    cfg = config.surface.ipts;
in {
    options.surface.ipts = {
        enable = mkEnableOption "Enable IPTSd for Microsoft Surface";
    };

    config = mkMerge [
        {
            surface.ipts.enable = mkDefault false;
        }
    
        (mkIf cfg.enable {
            systemd.services.iptsd = {
                description = "IPTSD";
                path = with pkgs; [ iptsd ];
                script = "iptsd $(iptsd-find-hidraw)";
                wantedBy = ["multi-user.target"];
            };
        })
    ];
}
