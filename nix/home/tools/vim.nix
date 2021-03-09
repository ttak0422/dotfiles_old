{ config, pkgs, lib, ... }:

let
  sources = import ./../../sources.nix;
  indentSpace = 2;
in {
  nixpkgs.overlays = [
    (import
      (builtins.fetchTarball { url = sources.neovim-nightly-overlay.url; }))
  ];
  programs = {
    vim.enable = true;
    neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      vimAlias = true;
      vimdiffAlias = true;
      extraConfig = ''
        set encoding=utf-8
        scriptencoding utf-8
        syntax enable
        filetype plugin indent on
        set cursorline
        set number
        set relativenumber
        set virtualedit=block
        set wildmenu
        " search
        set hlsearch
        set ignorecase
        set smartcase
        set incsearch
        " indent
        set tabstop=${toString indentSpace}
        set smartindent
        set clipboard+=${if pkgs.stdenv.isDarwin then "unnamed" else "unnamedplus"}
        " tab 
        set showtabline=2
        " statusline
        set laststatus=2
      '';
    };
  };
}
