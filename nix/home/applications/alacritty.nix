{ config, pkgs, lib, ... }:
let
  configPath = ".config/alacritty/alacritty.yml";
  fontSize = 16;
  padding = fontSize / 2;
  fontFamily = "Hack Nerd Font Mono";
  config = ''
    colors:
      primary:
        foreground: '#6c7680'
        background: '#fafafa'
      normal:
        black: '#000000'
        red: '#f07171'
        green: '#86b300'
        yellow: '#f2ae49'
        blue: '#399ee6'
        magenta: '#a37acc'
        cyan: '#4cbf99'
        white: '#c7c7c7'
      bright:
        black: '#686868'
        red: '#f07171'
        green: '#86b300'
        yellow: '#f2ae49'
        blue: '#399ee6'
        magenta: '#a37acc'
        cyan: '#4cbf99'
        white: '#d1d1d1'
      dim:
        black:   '#14151b'
        red:     '#ff2222'
        green:   '#1ef956'
        yellow:  '#ebf85b'
        blue:    '#4d5b86'
        magenta: '#ff46b0'
        cyan:    '#59dffc'
        white:   '#e6e6d1'    
      cursor:
        text: CellBackground
        cursor: CellForeground
      vi_mode_cursor:
        text: CellBackground 
        cursor: CellForeground
      search:
        matches:
          foreground: '#44475a'
          background: '#50fa7b'
        focused_match:
          foreground: '#44475a'
          background: '#ffb86c'
      selection:
        text: CellForeground
        background: '#e8eef4'
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
