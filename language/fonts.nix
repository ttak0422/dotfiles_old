{ config, pkgs, lib, ... }:
{
  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      ipafont
      powerline-fonts
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "DejaVu Sans Mono" "IPAGothic" ];
        sansSerif = [ "DejaVu Sans" "IPAGothic" ];
        serif = [ "DejaVu Serif" "IPAGothic" ];
      };
    };
  };
}
