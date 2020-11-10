{ config, pkgs, lib, ... }: {
  services.picom = {
    enable = true;
    shadow = false;
    backend = "glx";
    wintypes = {
      tooltip = {
        fade = false;
        shadow = false;
      };
    };
    fade = false;
  };
}
