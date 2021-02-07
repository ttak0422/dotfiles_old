{ config, pkgs, lib, ... }:
{
  nix.nixPath =
    [ "darwin-config=$HOME/dotfiles/nix/darwin/desktop/configuration.nix"
      "darwin=$HOME/.nix-defexpr/channels/darwin"
      "$HOME/.nix-defexpr/channels"
  ];
}