{ config, pkgs, lib, ... }: {
  imports = [ ./lorri.nix ./peco.nix ./pet.nix ./procs.nix ./tmux.nix ./vim.nix ];
  home.packages = with pkgs;
    [
      asciidoctor
      bat
      coreutils-full
      figlet
      glow
      hey
      jq
      killall
      lsof
      neofetch
      ngrok
      niv
      nixfmt
      openssl
      packer
      ranger
      redis
      tree
      unzip
      wget
      whois
      xclip
      yamllint
      zip
    ] ++ (if stdenv.isDarwin then [ ] else [ bmon feh ]);
}
