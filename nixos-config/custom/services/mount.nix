{ config, lib, pkgs, ... }: {
    ##### interface. here we define the options that users of our service can specify
    options = {
        # the options for our service will be located under services.foo
        services.automount = { 
        enable = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = ''
            Whether to enable the disk automounting service.
            '';
        };
        };
    };

    ##### implementation
    config = lib.mkIf config.services.automount.enable { # only apply the following settings if enabled
        systemd.services.automount = {
            wantedBy = ["multi-user.target"];
            after = ["local-fs.target"];
            serviceConfig.WorkingDirectory = "";
            preStart= ''
                ${pkgs.coreutils}/bin/echo Starting...
                ${pkgs.coreutils}/bin/echo Starting2...
                isMounted() { 
                    ${pkgs.util-linux}/bin/findmnt "$1" >/dev/null;
                }

                for file in /dev/disk/by-label/* 
                do
                    if ! isMounted /dev/disk/by-label/$(${pkgs.coreutils}/bin/basename $file)
                    then
                        ${pkgs.coreutils}/bin/echo Mounting $file...
                        ${pkgs.util-linux}/bin/mount /dev/disk/by-label/$(${pkgs.coreutils}/bin/basename $file) /mnt/$(${pkgs.coreutils}/bin/basename $file) --mkdir
                    fi
                done
            '';
            serviceConfig.ExecStart = "${pkgs.coreutils}/bin/true";
        };
    };
}