{ config, pkgs, lib, ... }:
{
  environment.systemPackages = [
    pkgs.google-chrome
    pkgs.vscode
    pkgs.termite
    pkgs.slack
    pkgs.typora
  ];
}
