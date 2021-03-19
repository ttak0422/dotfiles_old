{ pkgs, ... }: 
let 
  configPath = ".config/i3/config";
  mod = "Mod4";
  alt = "Mod1";
  font = "font";
  terminal = "alacritty";
  launcher = "i3-dmenu-desktop";

in {
  home.file."${configPath}".text = ''
    # set
    set $mod ${mod}
    set $alt ${alt}

    # terminal
    bindsym $mod+Return exec ${terminal}

    bindsym $mod+d exec --no-startup-id ${launcher}

    # kill
    bindsym $mod+Shift+q kill

    # change focus
    bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # move focused window
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    # enter fullscreen mode for the focused container
    bindsym $mod+z fullscreen toggle

    # mode
    bindsym $alt+r mode "resize"
    bindsym $alt+h split h
    bindsym $alt+v split v
    bindsym $alt+s layout stacking
    bindsym $alt+t layout tabbed
    bindsym $alt+space layout toggle split
    bindsym $alt+Shift+space floating toggle

    # define workspace
    set $ws1 "1"
    set $ws2 "2"
    set $ws3 "3"
    set $ws4 "4"
    set $ws5 "5"
    set $ws6 "6"
    set $ws7 "7"
    set $ws8 "8"
    set $ws9 "9"
    set $ws10 "10"

    # switch to workspace
    bindsym $mod+1 workspace number $ws1
    bindsym $mod+2 workspace number $ws2
    bindsym $mod+3 workspace number $ws3
    bindsym $mod+4 workspace number $ws4
    bindsym $mod+5 workspace number $ws5
    bindsym $mod+6 workspace number $ws6
    bindsym $mod+7 workspace number $ws7
    bindsym $mod+8 workspace number $ws8
    bindsym $mod+9 workspace number $ws9
    bindsym $mod+0 workspace number $ws10

    # move focused container to workspace
    bindsym $mod+Shift+1 move container to workspace number $ws1
    bindsym $mod+Shift+2 move container to workspace number $ws2
    bindsym $mod+Shift+3 move container to workspace number $ws3
    bindsym $mod+Shift+4 move container to workspace number $ws4
    bindsym $mod+Shift+5 move container to workspace number $ws5
    bindsym $mod+Shift+6 move container to workspace number $ws6
    bindsym $mod+Shift+7 move container to workspace number $ws7
    bindsym $mod+Shift+8 move container to workspace number $ws8
    bindsym $mod+Shift+9 move container to workspace number $ws9
    bindsym $mod+Shift+0 move container to workspace number $ws10

    # reload the configuration file
    bindsym $mod+Shift+c reload

    # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
    bindsym $mod+Shift+r restart

    mode "resize" {
      # resize
      bindsym h resize shrink width 10 px or 10 ppt
      bindsym j resize grow height 10 px or 10 ppt
      bindsym k resize shrink height 10 px or 10 ppt
      bindsym l resize grow width 10 px or 10 ppt
      bindsym Left resize shrink width 10 px or 10 ppt
      bindsym Down resize grow height 10 px or 10 ppt
      bindsym Up resize shrink height 10 px or 10 ppt
      bindsym Right resize grow width 10 px or 10 ppt

      # back to normal: Enter or Escape or $alt+r
      bindsym Return mode "default"
      bindsym Escape mode "default"
      bindsym $alt+r mode "default"
    }
    '';
}
