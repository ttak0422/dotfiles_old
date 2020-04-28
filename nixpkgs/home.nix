{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "20.03";
  imports = [
    ./user/tak.nix
    ./git/index.nix
    ./teminal/tmux.nix
    ./teminal/fish.nix
  ];
}
