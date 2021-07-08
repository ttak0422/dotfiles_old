{ config, pkgs, lib, ... }: {
  imports = [
    ./system
    ./tools/brew.nix
    ./window-manager/skhd.nix
    ./window-manager/yabai.nix
  ];
  programs.zsh.enable = true;
  nix.nixPath = [
    "darwin-config=$HOME/dotfiles/nix/darwin/desktop/configuration.nix"
    "darwin=$HOME/.nix-defexpr/channels/darwin"
    "$HOME/.nix-defexpr/channels"
  ];
}
