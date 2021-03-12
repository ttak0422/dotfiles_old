{ config, pkgs, lib, ... }:

{
  home.packages = [ pkgs.fd ];
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
  };
}
