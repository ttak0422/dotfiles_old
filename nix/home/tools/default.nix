{ config, pkgs, lib, ... }: {
  imports = [
    ./bat.nix
    ./fzf.nix
    # ./glow.nix
    ./lorri.nix
    ./peco.nix
    ./pet.nix
    # ./procs.nix
    ./tmux.nix
    ./vim.nix
  ];
  home.packages = with pkgs;
    [
      asciidoctor # adoc
      coreutils-full # cat, ls, mv, wget, ...
      cmake
      direnv # env switcher
      exa # ls clone
      hey # load test tool
      htop # top clone
      jq # JSON processor
      yq # JSON processor
      neofetch # system information tool
      # niv
      # nixfmt
      pkg-config # compile helper
      ranger # cui filer
      redis # kvs
      ripgrep # grep clone
      wget # GNU Wget
    ] ++ (if stdenv.isDarwin then [ ] else [ bmon feh ]);
}
