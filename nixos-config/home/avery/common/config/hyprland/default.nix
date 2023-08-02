{ system-settings, ... }: {
    xdg.configFile."hypr/hyprland.conf".text = ''
    
    ${system-settings}

    # Some default env vars.
    env = XCURSOR_SIZE,48

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options =
        kb_rules =
        follow_mouse = 2
        float_switch_override_focus = false
        natural_scroll = false
        touchpad {
            natural_scroll = true
            scroll_factor = 0.3
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(33ccffee)
        col.inactive_border = rgba(595959aa)

        layout = dwindle
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        rounding = 10
        blur = yes
        blur_size = 5
        blur_passes = 4
        blur_xray = false
        blur_ignore_opacity = false
        blur_new_optimizations = on

        drop_shadow = no
        shadow_range = 10
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }off

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = on
    }

    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
    device:epic-mouse-v1 {
        sensitivity = -0.5
    }

    windowrulev2 = opacity 0.8 0.8,class:^(kitty)$

    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
    exec-once=hyprpaper    
    exec-once=dunst

    # Focus Workspace 1
    exec-once=hyprctl dispatch workspace 1
    
    # Set the cursor theme
    exec-once=hyprctl setcursor Catppuccin-Mocha-Light-Cursors 48
    

    #See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, return, exec, kitty
    bind = $mainMod, C, killactive, 
    bind = $mainMod, M, exit, 
    bind = $mainMod, E, exec, dolphin
    bind = $mainMod, V, togglefloating, 
    bind = $mainMod, J, togglesplit, # dwindle
    bind = $mainMod, F, fullscreen,
    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Open Application Launcher
    bind = $mainMod, P, exec, wofi --show drun

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, moveworkspacetomonitor, 1 current
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, moveworkspacetomonitor, 2 current
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, moveworkspacetomonitor, 3 current
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, moveworkspacetomonitor, 4 current
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, moveworkspacetomonitor, 5 current
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, moveworkspacetomonitor, 6 current
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, moveworkspacetomonitor, 7 current
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, moveworkspacetomonitor, 8 current
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, moveworkspacetomonitor, 9 current
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 10, moveworkspacetomonitor, 10 current
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    bind = ,XF86MonBrightnessUp,exec,brightnessctl +5%
    bind = ,XF86MonBrightnessDown,exec,brightnessctl 5%-

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    '';
}
