{ config, pkgs, lib, ... }: {
  imports = [
    ./peco.nix
    ./pet.nix
    ./scripts
    ./shell
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
  home.packages = with pkgs;
    [
      coreutils-full
      xclip
      jq
      wget
      zip
      unzip
      tree
      bat
      neofetch
      ranger
      lsof
      niv
      nixfmt
      killall
      figlet
      asciidoctor
      packer
      yamllint
      hey
      ngrok
      bottom
    ] ++ (if stdenv.isDarwin then
      [ ]
    else [
      pkgs.bmon
      pkgs.feh

    ]);
}
