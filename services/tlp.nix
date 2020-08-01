{ config, lib, ... }:
{
  services.tlp = {
    enable = true;
      extraConfig = ''
        START_CHARGE_THRESH_BAT0=40
        STOP_CHARGE_THRESH_BAT0=80
    '';
  };
}