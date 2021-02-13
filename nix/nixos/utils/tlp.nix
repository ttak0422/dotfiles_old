{ config, lib, ... }: {
  services.tlp = {
    enable = true;
    extraConfig = ''
      START_CHARGE_THRESH_BAT0=50
      STOP_CHARGE_THRESH_BAT0=80
    '';
  };
}
