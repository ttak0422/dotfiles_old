{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    wget
    zip
    unzip
    tree
    bat
    neofetch
    bmon
    ranger
    feh
    htop
  ];
}
