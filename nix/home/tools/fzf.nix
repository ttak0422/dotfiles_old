# fuzzy finder
{ config, pkgs, lib, ... }:

{
  home.packages = [
    pkgs.fd # find clone
  ];
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    fileWidgetCommand = "fd --type f";
  };
}
