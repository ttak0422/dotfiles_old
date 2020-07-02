{ config, lib, ... }:
{
  programs.home-manager.enable = true;
  home.stateVersion = "20.03";
  imports = [
    ./../../nixpkgs/user/tak.nix
    ./../../nixpkgs/git/index.nix
    ./../../nixpkgs/terminal/tmux.nix
    ./../../nixpkgs/terminal/fish.nix
    ./../../nixpkgs/terminal/bash.nix
    ./../../nixpkgs/wip/peco.nix
  ];
  # for bash
  home.file.".profile".text = lib.mkAfter ". $HOME/.nix-profile/etc/profile.d/nix.sh";
  # https://wiki.archlinux.jp/index.php/Fish
  home.file.".bashrc".text = lib.mkAfter "exec fish";
}
