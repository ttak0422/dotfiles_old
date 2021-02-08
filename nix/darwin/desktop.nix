{ config, pkgs, lib, ... }: {
  imports = [ ./system ./tools ./window-manager ];
  nix.nixPath = [
    "darwin-config=$HOME/dotfiles/nix/darwin/desktop/configuration.nix"
    "darwin=$HOME/.nix-defexpr/channels/darwin"
    "$HOME/.nix-defexpr/channels"
  ];
}
