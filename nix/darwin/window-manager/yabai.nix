{ config, pkgs, lib, ... }:
with lib;
let
  mkSpaces = { space, label }: "yabai -m space ${space} --label ${label}";
  mkRules = { app, rule }: "yabai -m rule --add app=${app} ${rule}";
  f = strings.concatMapStringsSep "\n";
  spaces = f mkSpaces [ ];
  rules = f mkRules [ ];
in {
  services.yabai = {
    enable = true;
    package = pkgs.yabai;
    enableScriptingAddition = true;
    config = {
      mouse_follows_focus = "on";
      focus_follows_mouse = "off";
      window_shadow = "off";
      layout = "bsp";
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      auto_balance = "on";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      window_opacity = "on";
      active_window_opacity = "1.0";
      normal_window_opacity = "0.85";
    };
    extraConfig = spaces + "\n" + rules + ''
      yabai -m space --gap abs:12
      yabai -m config external_bar all:0:26         
    '';
  };
}
