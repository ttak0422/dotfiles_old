{ config, pkgs, lib, ... }:
# TODO: refactor
let

  config' = ''
    # set
    set $mod Mod4
    set $alt Mod1
    set $execi exec --no-startup-id

    # font
    font pango:DejaVu Sans Mono, Awesome 14
    # The combination of xss-lock, nm-applet and pactl is a popular choice, so
    # they are included here as an example. Modify as you see fit.

    # lock
    exec --no-startup-id xss-lock --transfer-sleep-lock -- i3lock --nofork
    bindsym $super+l exec i3lock # -i ~/.wallpaper.png

    # backlight
    bindsym XF86MonBrightnessUp exec  brightnessctl s +10%
    bindsym XF86MonBrightnessDown exec  brightnessctl s 10%-

    # NetworkManager is the most popular way to manage wireless networks on Linux,
    # and nm-applet is a desktop environment-independent system tray GUI for it.
    exec --no-startup-id nm-applet

    # Use pactl to adjust volume in PulseAudio.
    # set $refresh_i3status killall -SIGUSR1 i3status
    bindsym XF86AudioRaiseVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% 
    bindsym XF86AudioLowerVolume exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10%
    bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle
    bindsym XF86AudioMicMute exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle

    # Use Mouse+$mod to drag floating windows to their wanted position
    floating_modifier $mod

    # start a terminal
    bindsym $mod+Return exec termite

    # kill focused window
    bindsym $mod+Shift+q kill

    # start dmenu (a program launcher)
    bindsym $mod+d $execi sh -c "rofi -show run"
    # There also is the (new) i3-dmenu-desktop which only displays applications
    # shipping a .desktop file. It is a wrapper around dmenu, so you need that
    # installed.
    # bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

    # change focus
    bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right

    # alternatively, you can use the cursor keys:
    bindsym $mod+Left focus left
    bindsym $mod+Down focus down
    bindsym $mod+Up focus up
    bindsym $mod+Right focus right

    # move focused window
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right

    # alternatively, you can use the cursor keys:
    bindsym $mod+Shift+Left move left
    bindsym $mod+Shift+Down move down
    bindsym $mod+Shift+Up move up
    bindsym $mod+Shift+Right move right

    # enter fullscreen mode for the focused container
    bindsym $mod+f fullscreen toggle

    # mode
    bindsym $alt+h split h
    bindsym $alt+v split v
    bindsym $alt+s layout stacking
    bindsym $alt+t layout tabbed
    bindsym $alt+space layout toggle split
    bindsym $alt+Shift+space floating toggle

    # Define names for default workspaces for which we configure key bindings later on.
    # We use variables to avoid repeating the names in multiple places.
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
    # exit i3 (logs you out of your X session)
    # bindsym $mod+Shift+e exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -B 'Yes, exit i3' 'i3-msg exit'"
    set $mode_system System (l) lock, (e) logout, (s) suspend, (h) hibernate, (r) reboot, (Shift+s) shutdown
    mode "$mode_system" {
      bindsym l exec --no-startup-id i3exit lock, mode "default"
      bindsym e exec --no-startup-id pkill x, mode "default"
      bindsym s exec --no-startup-id systemctl suspend, mode "default"
      bindsym h exec --no-startup-id i3exit hibernate, mode "default"
      bindsym r exec --no-startup-id i3exit reboot, mode "default"
      bindsym Shift+s exec --no-startup-id i3exit shutdown, mode "default"

      # back to normal: Enter or Escape
      bindsym Return mode "default"
      bindsym Escape mode "default"
    }
    bindsym $mod+Shift+e mode "$mode_system"

    # screenshot
    bindsym --release Print exec scrot 'screenshot_%Y%m%d_%H%M%S.png' -e 'mkdir -p ~/Pictures/screenshots && mv $f ~/Pictures/screenshots && xclip -selection clipboard -t image/png -i ~/Pictures/screenshots/`ls -1 -t ~/Pictures/screenshots | head -1`' # All screens

    # resize window (you can also use the mouse for that)
    mode "resize" {
      # These bindings trigger as soon as you enter the resize mode

      # Pressing left will shrink the window’s width.
      # Pressing right will grow the window’s width.
      # Pressing up will shrink the window’s height.
      # Pressing down will grow the window’s height.
      bindsym j resize shrink width 10 px or 10 ppt
      bindsym k resize grow height 10 px or 10 ppt
      bindsym l resize shrink height 10 px or 10 ppt
      bindsym semicolon resize grow width 10 px or 10 ppt

      # same bindings, but for the arrow keys
      bindsym Left resize shrink width 10 px or 10 ppt
      bindsym Down resize grow height 10 px or 10 ppt
      bindsym Up resize shrink height 10 px or 10 ppt
      bindsym Right resize grow width 10 px or 10 ppt

      # back to normal: Enter or Escape or $mod+r
      bindsym Return mode "default"
      bindsym Escape mode "default"
      bindsym $mod+r mode "default"
    }

    bindsym $mod+r mode "resize"

    # polybar
    exec --no-startup-id "polybar top" 

    # i3-gaps
    smart_gaps on
    gaps inner 12
    gaps outer 2

    # window rules, you can find the window class using xprop
    for_window [class=".*"] border pixel 4
    assign [class=URxvt] 1
    assign [class=Firefox|Transmission-gtk] 2
    assign [class=Thunar|File-roller] 3
    assign [class=Geany|Evince|Gucharmap|Soffice|libreoffice*] 4
    assign [class=Audacity|Vlc|mpv|Ghb|Xfburn|Gimp*|Inkscape] 5
    assign [class=Lxappearance|System-config-printer.py|Lxtask|GParted|Pavucontrol|Exo-helper*|Lxrandr|Arandr] 6
    for_window [class=Viewnior|feh|Audacious|File-roller|Lxappearance|Lxtask|Pavucontrol] floating enable
    for_window [class=URxvt|Firefox|Geany|Evince|Soffice|libreoffice*|mpv|Ghb|Xfburn|Gimp*|Inkscape|Vlc|Lxappearance|Audacity] focus
    for_window [class=Xfburn|GParted|System-config-printer.py|Lxtask|Pavucontrol|Exo-helper*|Lxrandr|Arandr] focus

    # colour of border, background, text, indicator, and child_border
    client.focused              #bf616a #2f343f #d8dee8 #bf616a #d8dee8
    client.focused_inactive     #2f343f #2f343f #d8dee8 #2f343f #2f343f
    client.unfocused            #2f343f #2f343f #d8dee8 #2f343f #2f343f
    client.urgent               #2f343f #2f343f #d8dee8 #2f343f #2f343f
    client.placeholder          #2f343f #2f343f #d8dee8 #2f343f #2f343f
    client.background           #2f343f
  '';
in {
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };
    displayManager = { defaultSession = "xfce+i3"; };
    windowManager.i3 = {
      enable = true;
      configFile = "/etc/i3.conf";
      package = pkgs.i3-gaps;
      extraPackages = with pkgs; [ rofi i3lock acpi scrot brightnessctl ];
    };
  };
  environment.etc."i3.conf".text = config';
}
