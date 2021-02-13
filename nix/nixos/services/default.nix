{ config, pkgs, lib, ... }: {
  imports = [
    ./xserver/i3-xfce.nix
    ./picom.nix
  ];
  services.xserver.enable = true;
}
