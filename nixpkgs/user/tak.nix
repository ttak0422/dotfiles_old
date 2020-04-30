{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    nixfmt
    bat
    zip
    unzip
    tree
    peco
    ghq
    gitAndTools.hub
  ];
}