{ config, pkgs, lib, ... }:
let
  mod = "alt";
  resize = 20;
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
    # increase window size
    ${mod} - w : yabai -m window --resize top:0:-${toString resize}
    ${mod} - a : yabai -m window --resize left:-${toString resize}:0
    ${mod} - s : yabai -m window --resize bottom:0:${toString resize}
    ${mod} - d : yabai -m window --resize right:${toString resize}:0
    # toggle window fullscreen zoom
    ${mod} - f : yabai -m window --toggle zoom-fullscreen
      '';
in {
  services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = config;
  };
}
