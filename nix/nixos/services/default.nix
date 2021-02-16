{ config, pkgs, lib, ... }: {
  imports = [ ./xserver/i3-xfce.nix ./picom.nix ];
  environment.systemPackages = with pkgs; [ gnome3.seahorse gnome3.libsecret ];
  services.xserver.enable = true;
  services.gnome3.gnome-keyring.enable = true;
}
