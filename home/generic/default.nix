{ config, pkgs, lib, ... }: {
  imports = [
    ./peco.nix
    ./bash.nix
    ./fish.nix
    ./git
    ./vim.nix
    ./lorri.nix
    ./tmux.nix
    ./virtualization
    ./development
  ];
  home.packages = with pkgs; [
    xclip
    jq
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
    lsof
    niv
    nixfmt
    killall
    figlet
    asciidoctor
  ];
}
