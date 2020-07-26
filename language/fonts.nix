{ config, pkgs, lib, ... }:
{
  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      ipafont
      powerline-fonts
      fantasque-sans-mono
      iosevka
      noto-fonts-cjk
      comfortaa
      # (nerdfonts.override { withFont = "Hurmit";})
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
