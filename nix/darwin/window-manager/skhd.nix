{ config, pkgs, lib, ... }:
let
  mod = "alt";
  resize = 40;
  densePadding = 12;
  sparsePaddingH = 100;
  sparsePaddingV = 20;
  config = ''
    # focus window
    ${mod} - h : yabai -m window --focus west
    ${mod} - j : yabai -m window --focus south
    ${mod} - k : yabai -m window --focus north
    ${mod} - l : yabai -m window --focus east
    # swap window
    shift + ${mod} - h : yabai -m window --swap west
    shift + ${mod} - j : yabai -m window --swap south
    shift + ${mod} - k : yabai -m window --swap north
    shift + ${mod} - l : yabai -m window --swap east
    # move window
    shift + ${mod} - 1 : yabai -m window --space 1
    shift + ${mod} - 2 : yabai -m window --space 2
    shift + ${mod} - 3 : yabai -m window --space 3
    shift + ${mod} - 4 : yabai -m window --space 4
    shift + ${mod} - 5 : yabai -m window --space 5
    shift + ${mod} - 6 : yabai -m window --space 6
    shift + ${mod} - 7 : yabai -m window --space 7
    shift + ${mod} - 8 : yabai -m window --space 8
    shift + ${mod} - 9 : yabai -m window --space 9
    shift + ${mod} - 0 : yabai -m window --space 10
    # move space
    ${mod} - 1 : yabai -m space --focus 1
    ${mod} - 2 : yabai -m space --focus 2
    ${mod} - 3 : yabai -m space --focus 3
    ${mod} - 4 : yabai -m space --focus 4
    ${mod} - 5 : yabai -m space --focus 5
    ${mod} - 6 : yabai -m space --focus 6
    ${mod} - 7 : yabai -m space --focus 7
    ${mod} - 8 : yabai -m space --focus 8
    ${mod} - 9 : yabai -m space --focus 9
    ${mod} - 0 : yabai -m space --focus 10
    # increase window size
    ${mod} - w : yabai -m window --resize top:0:-${toString resize}
    ${mod} - a : yabai -m window --resize left:-${toString resize}:0
    ${mod} - s : yabai -m window --resize bottom:0:${toString resize}
    ${mod} - d : yabai -m window --resize right:${toString resize}:0
    # decrease window size
    shift + ${mod} - w : yabai -m window --resize top:0:${toString resize}
    shift + ${mod} - a : yabai -m window --resize left:${toString resize}:0
    shift + ${mod} - s : yabai -m window --resize bottom:0:-${toString resize}
    shift + ${mod} - d : yabai -m window --resize right:-${toString resize}:0
    # toggle window fullscreen zoom
    ${mod} - z : yabai -m window --toggle zoom-fullscreen
    # float window
    ${mod} - f : yabai -m window --toggle float && yabai -m window --grid 10:10:2:1:7:8

    # [WIP] dense padding
    ${mod} - x : yabai -m config top_padding ${toString densePadding} & \
      yabai -m config left_padding ${toString densePadding} & \
      yabai -m config right_padding ${toString densePadding} & \
      yabai -m config bottom_padding ${toString densePadding}
    
    # [WIP] sparse padding
    ${mod} - c : yabai -m config top_padding ${toString sparsePaddingV} & \
      yabai -m config left_padding ${toString sparsePaddingH} & \
      yabai -m config right_padding ${toString sparsePaddingH} & \
      yabai -m config bottom_padding ${toString sparsePaddingV}

    # term
    ${mod} - return : ${SWAP_TERM}/bin/SWAP_TERM
      '';
  SWAP_TERM = pkgs.writeScriptBin "SWAP_TERM" ''
    #!/usr/bin/osascript
    
    on checkRunning (processName)
      tell application "System Events" to (name of processes) contains processName
    end checkRunning
    
    on getFrontmost ()
      tell application "System Events"
        name of first window of (first application process whose frontmost is true) 
      end tell
    end getFrontmost
    
    set term to "Alacritty"
    set preTermRunning to checkRunning (term)
    set preFrontmost to getFrontmost ()
    
    tell application term to activate -- 高速化のため
    
    tell application "System Events"
      if preTermRunning and preFrontmost = term then
        set visible of application process term to false
      end if
    end tell
  '';
in {
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = config;
  };
  environment.systemPackages = [ SWAP_TERM ];
}
