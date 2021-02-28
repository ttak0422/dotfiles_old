{ config, pkgs, lib, ... }:

let sources = import ./../../sources.nix;
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
    };
  };
}
