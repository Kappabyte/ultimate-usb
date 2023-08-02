{ config, pkgs, ... }: {
    programs.ssh.startAgent = true;
}
