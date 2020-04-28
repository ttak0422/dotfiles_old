{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nixfmt
    bat
    zip
    unzip
    tree
    # tig
    peco
    ghq
    gitAndTools.hub
    powerline-go
  ];
}