{ config, pkgs, lib, ... }:
{
  imports = [ ./i3.nix ];
  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "displaylink" "modesetting" ];
  };
}
