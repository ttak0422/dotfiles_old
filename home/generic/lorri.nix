{ config, pkgs, ... }:

{
  services.lorri = {
    enable = true;
  };
  home.packages = with pkgs; [
    direnv
  ];
  programs.fish = {
    shellInit = ''
      eval (direnv hook fish)
    '';
  };
}
