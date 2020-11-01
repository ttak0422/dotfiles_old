{ config, pkgs, lib, ... }: {
  imports = [ ./i3-xfce.nix ];
  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "displaylink" "modesetting" ];
  };
}
