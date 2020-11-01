# https://nixos.wiki/wiki/Android
{ config, pkgs, lib, ... }: {
  programs.adb.enable = true;
  # users.users.foo.extraGroups = [
  #   "adbusers"
  # ];
}
