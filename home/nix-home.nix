{ config, pkgs, lib, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = "20.09";
  imports = [ ./generic ./nixos ./nixos/polybar.nix ];
}
