{ config, pkgs, lib, ... }: {
  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      ipafont
      powerline-fonts
      font-awesome-ttf
      fira-code
      fira-code-symbols
      fantasque-sans-mono
      iosevka
      noto-fonts-cjk
      comfortaa
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
