{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "20.03";
  imports = [
    ./user/tak.nix
    ./git/index.nix
    ./terminal/tmux.nix
    ./terminal/fish.nix
    ./terminal/bash.nix
    ./terminal/zsh.nix
  ];
}
