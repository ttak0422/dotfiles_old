{ config, pkgs, lib, ... }:
let
  configPath = ".config/alacritty/alacritty.yml";
  padding = 5;
  config = ''
    window:
      decorations: none
      padding:
        x: ${toString padding}
        y: ${toString padding}
  '';
in { home.file."${configPath}".text = config; }
