{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ git tig ghq gitAndTools.gh ];
  imports = [ ./config.nix ./template.nix ./ignore.nix ./tig.nix ];
}
