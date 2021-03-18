{ config, pkgs, lib, ... }: {
  imports = [
    ./fzf.nix
    ./glow.nix
    ./lorri.nix
    ./peco.nix
    ./pet.nix
    ./procs.nix
    ./tmux.nix
    ./vim.nix
  ];
  home.packages = with pkgs;
    [
      asciidoctor
      bat
      bottom
      coreutils-full
      cmake
      direnv
      exa
      fontconfig
      figlet
      file
      hey
      htop
      jq
      killall
      lsof
      neofetch
      ngrok
      niv
      nixfmt
      openssl
      packer
      pkg-config
      ranger
      redis
      ripgrep
      screenfetch
      tree
      unzip
      wget
      whois
      xclip
      yamllint
      zip
    ] ++ (if stdenv.isDarwin then [ ] else [ bmon feh ]);
}
