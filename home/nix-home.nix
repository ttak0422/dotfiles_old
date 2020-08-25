{ config, pkgs, lib, ... }: {
  programs.home-manager.enable = true;
  home.stateVersion = "20.03";
  imports = [ ./generic ./nixos ./nixos/polybar.nix ];
}
