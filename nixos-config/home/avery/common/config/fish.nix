{ lib, inputs, pkgs, user, home-manager, ... }: {
   programs.fish = {
        enable = true;
        interactiveShellInit = ''
            function fish_greeting
                if test -e .git/
                    onefetch
                else
                    neofetch
                end
            end
            function __fish_command_not_found_handler --on-event="fish_command_not_found"
                echo $argv[1]: command not found
            end

            fish_ssh_agent
            
            if not set -q TMUX
                exec tmux new -A -s avery
            end
        '';

        functions = {
            __ssh_agent_is_started = {
                body = ''
                    if begin; test -f $SSH_ENV; and test -z "$SSH_AGENT_PID"; end
                        source $SSH_ENV > /dev/null
                    end

                    if test -z "$SSH_AGENT_PID"
                        return 1
                    end

                    ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep -q ssh-agent
                    return $status
                '';
            };


            __ssh_agent_start = {
                body = ''
                    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
                    chmod 600 $SSH_ENV
                    source $SSH_ENV > /dev/null
                    true  # suppress errors from setenv, i.e. set -gx
                '';
            };


            fish_ssh_agent = {
                body = ''
                    if test -z "$SSH_ENV"
                        set -xg SSH_ENV $HOME/.ssh/environment
                    end

                    if not __ssh_agent_is_started
                        __ssh_agent_start
                    end
                '';
            };
        };
        shellInit = ''
        direnv hook fish | source
        '';
        plugins = [
            { name = "pure"; src = pkgs.fishPlugins.pure.src; }
            { name = "grc"; src = pkgs.fishPlugins.grc.src; }
        ];
   };
}
