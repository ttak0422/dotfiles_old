{ config, pkgs, lib, ... }:

let
  colors = {
    mono0 = "#282c34";
    mono1 = "#545862";
    mono2 = "#abb2bf";
    mono3 = "#c8ccd4";
    mono4 = "#353b45";
    red = "#e06c75";
    green = "#98c379";
    yellow = "#e5c07b";
    blue = "#61afef";
    purple = "#c678dd";
    teal = "#56b6c2";
  };
in {
  services.polybar = {
    enable = true;
    script = "polybar top &";
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      # i3Support = true;
      githubSupport = true;
    };
    config = {
      "bar/top" = {
        monitor = "\${env:MONITOR:eDP-1}";
        bottom = true;
        width = "100%";
        height = "2%";
        offset-x = "0%";
        ffset-y = "0%";
        background = colors.mono0;
        horeground = colors.green;
        radius = 0;
        modules-left = "i3";
        modules-center = "date";
        modules-right = "battery";
        line-size = 3;
        line-color = "#f00";

        border-size = 0;
        border-color = "#00282c34";

        padding-left = 0;
        padding-right = 0;

        module-margin-left = 0;
        module-margin-right = 0;

        font-0 = "FSource Han Code JP H;0";
        font-1 = "FontAwesome5Free:style=Solid;4";
        font-2 = "FontAwesome5Free:style=Regular;4";
        font-3 = "FontAwesome5Brands:style=Regular;4";

      };
      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;
        # focused = Active workspace on focused monitor
        label-focused = "%index%";
        label-focused-background = colors.green;
        label-focused-foreground = colors.mono0;
        label-focused-padding = 2;

        # unfocused = Inactive workspace on any monitor
        label-unfocused = "%index%";
        label-unfocused-background = colors.mono4;
        label-unfocused-foreground = colors.mono2;
        label-unfocused-padding = 2;

        # visible = Active workspace on unfocused monitor
        label-visible = "%index%";
        label-visible-background = colors.mono4;
        label-visible-foreground = colors.mono2;
        label-visible-padding = 2;

        # urgent = Workspace with urgency hint set
        label-urgent = "%index%";
        label-urgent-background = colors.red;
        label-urgent-foreground = colors.mono0;
        label-urgent-padding = 2;
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%Y-%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
      };
      "module/battery" = {
        type = "custom/script";
        exec =
          "/run/current-system/sw/bin/bash /run/current-system/sw/bin/myPolyBarBattery";
        interval = 60;
        format-padding = 1;
        format-background = colors.mono4;
        format-foreground = colors.mono2;
      };
    };
  };
}
