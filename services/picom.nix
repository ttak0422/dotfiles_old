{ config, pkgs, lib, ... }:
{
  services.picom = {
    enable = true;
    shadow = false;
    # vSync = "opengl-swc";
    backend = "glx";
    # todo
    opacityRules = [
      "100:class_g = 'URxvt' && focused"
      "80:class_g = 'URxvt' && !focused"
    ];
    activeOpacity = "1.0";
    inactiveOpacity = "0.9";
    wintypes = {
      tooltip = {
        fade = true;
        shadow = false;
        opacity = "0.8";
      };
    };
    fadeDelta = 5;
    fadeSteps = [ "0.03" "0.03" ];
    fade = true;
  };
}