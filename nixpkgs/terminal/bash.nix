{ config, pkgs, lib, ... }:

{
  programs.bash = {
    enable = true;
    shellAliases = {
      "d" = "docker";
      "dc" = "docker";
    };
  };
}
