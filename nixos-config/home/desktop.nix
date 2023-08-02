{ lib, inputs, pkgs, user, home-manager, ... }: {
    avery = { 
        imports = [
            ./avery/common
            ./avery/desktop
        ];
    };
}
