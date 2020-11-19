{ config, pkgs, lib, ... }: {
  imports = [
    ./peco.nix
    ./bash.nix
    ./zsh.nix
    ./fish.nix
    ./git
    ./vim.nix
    ./tmux.nix
    ./virtualization
    ./development
    ./network
    ./lorri.nix
  ];
  #++ (if stdenv.isDarwin then [] else [
  #]);
  home.packages = with pkgs; [
    xclip
    jq
    wget
    zip
    unzip
    tree
    bat
    neofetch
    ranger
    htop
    lsof
    niv
    nixfmt
    killall
    figlet
    asciidoctor
    packer
  ] ++ (if stdenv.isDarwin then [] else [
    pkgs.bmon
    pkgs.feh

  ]);
}