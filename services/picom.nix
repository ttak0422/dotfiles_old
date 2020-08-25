{ config, pkgs, lib, ... }: {
  services.picom = {
    enable = true;
    shadow = false;
    backend = "glx";
    activeOpacity = "1.0";
    inactiveOpacity = "1.0";
    wintypes = {
      tooltip = {
        fade = false;
        shadow = false;
      };
    };
    fade = false;
  };
}
