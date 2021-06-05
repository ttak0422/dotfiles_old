{ config, pkgs, lib, ... }:
let
  configPath = ".config/alacritty/alacritty.yml";
  fontSize = 16;
  padding = fontSize / 2;
  fontFamily = "Hack Nerd Font Mono";
  #   # ayu
  #   light = {
  #     primary = {
  #       background = "#FAFAFA";
  #       foreground = "#575F66";
  #     };
  #     normal = {
  #       black = "#FAFAFA"; # 0
  #       red = "#F07178"; # 1
  #       green = "#86B300"; # 2
  #       yellow = "#FF6A00"; # 3
  #       blue = "#36A3D9"; # 4
  #       magenta = "#A37ACC"; #5
  #       cyan = "#4CBF99"; # 6
  #       white = "#575F66"; # 7
  #     };
  #     bright = {
  #       black = "#828C99"; # 8
  #       red = "#FF3333"; # 9
  #       green = "#86B300";# 10
  #       yellow = "#FF6A00"; # 11
  #       blue = "#36A3D9"; # 12
  #       magenta = "#A37ACC"; # 13
  #       cyan = "#4CBF99"; # 14
  #       white = "#ABB0B6"; # 15
  #     };
  #   };
  # one (https://github.com/alacritty/alacritty/wiki/Color-schemes)
  light = {
    primary = {
      background = "#fafafa";
      foreground = "#383a42";
    };
    cursor = {
      text = "CellBackground";
      cursor = "#526eff";
    };
    normal = {
      black = "#696c77"; # 0
      red = "#e45649"; # 1
      green = "#50a14f"; # 2
      yellow = "#c18401"; # 3
      blue = "#4078f2"; # 4
      magenta = "#a626a4"; # 5
      cyan = "#0184bc"; # 6
      white = "#a0a1a7"; # 7
    };
  };
  config = ''
    schemes:
      one_light: &light
        primary:
          background: '${light.primary.background}'
          foreground: '${light.primary.foreground}'
        cursor:
          text: ${light.cursor.text}
          cursor: '${light.cursor.cursor}'
        normal:
          black: '${light.normal.black}'
          red: '${light.normal.red}'
          green: '${light.normal.green}'
          yellow: '${light.normal.yellow}'
          blue: '${light.normal.blue}'
          magenta: '${light.normal.magenta}'
          cyan: '${light.normal.cyan}'
          white: '${light.normal.white}'
    colors: *light
    env:
      TERM: screen-256color
    window:
      decorations: ${if pkgs.stdenv.isLinux then "none" else "buttonless"}
      padding:
        x: ${toString padding}
        y: ${toString padding}
    key_bindings:
      - { key: Minus, mods: Command|Shift, action: IncreaseFontSize } # JISキーボードで文字サイズを変更するため
      - { key: Backslash, mods: Alt, chars: "\x5c" } # JISキーボードのMacでバックスラッシュを入力するため
    font:
      size: ${toString fontSize}
      normal:
        family: ${fontFamily}
        style: Regular
      bold:
        family: ${fontFamily}
        style: Bold
      italic:
        family: ${fontFamily}
        style: Italic
  '';
in { home.file."${configPath}".text = config; }
