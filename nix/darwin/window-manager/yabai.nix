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
      focus_follows_mouse = "autoraise";
      window_shadow = "off";
      layout = "bsp";
      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;
      auto_balance = "on";
      mouse_action1 = "move";
      mouse_action2 = "resize";
    };
    extraConfig = spaces + "\n" + rules;
  };
}
