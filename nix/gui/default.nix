{ config, pkgs, lib, ... }:
let
  sources = import ./../nix/sources.nix;
  pkgsUnstable = import sources.nixpkgs-unstable { config.allowUnfree = true; };
in {
  environment.systemPackages = [
    pkgs.firefox
    pkgs.google-chrome
    pkgs.vscode
    pkgs.termite
    pkgs.slack
    pkgs.teams
    pkgs.typora
    pkgsUnstable.unityhub
  ];
}
