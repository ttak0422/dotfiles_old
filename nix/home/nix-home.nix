{ config, pkgs, lib, ... }: {
  home.stateVersion = "20.09";
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  imports = [ ./generic ./nixos ./nixos/polybar.nix ];
}
