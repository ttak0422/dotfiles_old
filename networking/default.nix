{ config, lib, ... }:
{
  networking = {
    hostName = "nixos";
    useDHCP = false;
    networkmanager.enable = true;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
  };
  environment.etc = {
    "resolv.conf".text = ''
      nameserver 8.8.8.8
      nameserver 8.8.4.4
    '';
  };
}
