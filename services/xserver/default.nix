{ config, pkgs, lib, ... }: {
  imports = [ ./gnome.nix ];
  services.xserver = {
    enable = true;
    layout = "us";
    videoDrivers = [ "displaylink" "modesetting" ];
  };
}
