{ config, pkgs, lib, ... }:
{
  home.stateVersion = "20.03";
  imports = [
    ./peco.nix
    ./bash.nix
    ./fish.nix
    ./git
    ./vim.nix
  ];

  # home.file.".bashrc".text = lib.mkAfter "exec fish";
}
