{ config, pkgs, lib, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "20.03";
  imports = [
    ./user/tak.nix
    ./git/index.nix
    ./terminal/tmux.nix
    ./terminal/fish.nix
    ./terminal/bash.nix
    # ./terminal/zsh.nix
  ];
  home.sessionVariables = {
    TMUX_TMPDIR = "/tmp";
  };
  # for bash
  home.file.".profile".text = lib.mkAfter ". $HOME/.nix-profile/etc/profile.d/nix.sh";
  # https://wiki.archlinux.jp/index.php/Fish
  home.file.".bashrc".text = lib.mkAfter "exec fish";
}
