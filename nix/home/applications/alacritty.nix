{ config, pkgs, lib, ... }:
let
  configPath = ".config/alacritty/alacritty.yml";
  fontSize = 16;
  padding = fontSize / 2;
  fontFamily = "Fira Code";
  config = ''
    window:
      decorations: ${if pkgs.stdenv.isLinux then "none" else "buttonless"}
      padding:
        x: ${toString padding}
        y: ${toString padding}
    key_bindings:
      - { key: Minus, mods: Command|Shift, action: IncreaseFontSize } # JISキーボードで文字サイズを変更するため
    font:
      size: ${toString fontSize}
      normal:
        family: ${fontFamily}
        style: Light
      bold:
        family: ${fontFamily}
        style: Medium
      italic:
        family: ${fontFamily}
        style: Iosevka      
  '';
in { home.file."${configPath}".text = config; }
