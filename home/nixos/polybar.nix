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
  padding = 2;
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
        foreground = colors.green;
        radius = 0;
        modules-left = "i3";
        modules-center = "title";
        modules-right = "alsa backlight battery date";
        line-size = 3;
        line-color = "#f00";

        border-size = 0;
        border-color = "#00282c34";

        padding-left = 0;
        padding-right = 0;

        module-margin-left = 0;
        module-margin-right = 0;

        font-0 = "FontAwesome5Free:style=Solid;4";
        font-1 = "FontAwesome5Free:style=Regular;4";
        font-2 = "FontAwesome5Brands:style=Regular;4";
        font-3 = "FSource Han Code JP H;0";

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
        label-focused-padding = padding;

        # unfocused = Inactive workspace on any monitor
        label-unfocused = "%index%";
        label-unfocused-background = colors.mono4;
        label-unfocused-foreground = colors.mono2;
        label-unfocused-padding = padding;

        # visible = Active workspace on unfocused monitor
        label-visible = "%index%";
        label-visible-background = colors.mono4;
        label-visible-foreground = colors.mono2;
        label-visible-padding = padding;

        # urgent = Workspace with urgency hint set
        label-urgent = "%index%";
        label-urgent-background = colors.red;
        label-urgent-foreground = colors.mono0;
        label-urgent-padding = padding;
      };
      "module/date" = {
        type = "internal/date";
        internal = 5;
        date = "%m-%d";
        time = "%H:%M";
        label = "%date% %time%";
        format-padding = padding;
        format-background = colors.green;
        format-foreground = colors.mono0;

      };
      "module/alsa" = {
        type = "internal/alsa";

        format-volume = "<ramp-volume> <label-volume>";
        format-volume-background = colors.mono4;
        format-volume-foreground = colors.mono2;
        format-volume-padding = padding;
        format-muted-background = colors.mono4;
        format-muted-foreground = colors.mono2;

        label-volume = "%percentage%%";
        label-muted = " Muted";
        label-muted-padding = padding;
        #label-muted-foreground = ${color.fg-alt}

        ramp-volume-0 = "";
        ramp-volume-1 = "";
        ramp-volume-2 = "";
        ramp-volume-3 = "";
      };

      "module/backlight" = {
        type = "internal/xbacklight";

        card = "intel_backlight";
        format = "<ramp>";

        ramp-0 = "";
        ramp-1 = "";
        ramp-2 = "";
        ramp-3 = "";
        ramp-4 = "";
      };
      "module/title" = {
        type = "internal/xwindow";

        format = "<label>";

        label = "%title%";
        label-maxlen = 25;
      };
      "module/battery" = {
        type = "internal/battery";

        full-at = 99;

        battery = "BAT0";
        adapter = "AC";

        poll-interval = 2;
        time-format = "%H:%M";

        format-charging = "<animation-charging> <label-charging>";
        format-discharging = "<ramp-capacity> <label-discharging>";
        format-full = "<ramp-capacity> <label-full>";

        format-charging-background = colors.mono4;
        format-charging-foreground = colors.mono2;
        format-charging-padding = padding;
        format-discharging-background = colors.mono4;
        format-discharging-foreground = colors.mono2;
        format-discharging-padding = padding;
        format-full-foreground = colors.mono4;
        format-full-background = colors.mono2;
        format-full-padding = padding;
        label-charging = "%percentage%%";
        label-discharging = "%percentage%%";
        label-full = "Charged";

        ramp-capacity-0 = "";
        ramp-capacity-1 = "";
        ramp-capacity-2 = "";
        ramp-capacity-3 = "";
        ramp-capacity-4 = "";

        animation-charging-0 = "";
        animation-charging-1 = "";
        animation-charging-2 = "";
        animation-charging-3 = "";
        animation-charging-4 = "";

        animation-charging-framerate = 750;
      };
    };
  };
}
