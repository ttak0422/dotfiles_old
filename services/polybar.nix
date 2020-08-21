# TODO: 実行されない？
{ config, pkgs, lib, ... }: {
  services.polybar = {
    enable = true;
    script = "polybar top &";
    package = pkgs.polybar.override { i3GapsSupport = true; };
    config = {
      "bar/top" = {
        monitor = "\${env:MONITOR:eDP1}";
        width = "100%";
        height = "3%";
        radius = 0;
        modules-center = "date";
      };
    };
  };
}
