{ config, pkgs, lib, ... }:
{
  home.stateVersion = "20.03";
  imports = [
    ./peco.nix
    ./bash.nix
    ./fish.nix
    ./git
    ./vim.nix
    ./lorri.nix
    ./tmux.nix
  ];
}
