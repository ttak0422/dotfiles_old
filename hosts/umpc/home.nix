{ config, lib, pkgs, ... }: {
  imports = [
    ./../../nixpkgs/user/tak.nix
    ./../../nixpkgs/git/index.nix
    ./../../nixpkgs/terminal/tmux.nix
    ./../../nixpkgs/terminal/fish.nix
    ./../../nixpkgs/terminal/bash.nix
    ./../../nixpkgs/terminal/zsh.nix
    ./../../nixpkgs/wip/peco.nix
    # ./../../services/polybar.nix
  ];
  # for bash
  # https://wiki.archlinux.jp/index.php/Fish
  home.file.".bashrc".text = lib.mkAfter "exec fish";
}
