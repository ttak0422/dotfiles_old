{ config, pkgs, lib, ... }: {
  services = {
    xserver = {
      enable = true;
      layout = "us";
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = false;
      desktopManager.gnome3.enable = true;
    };

    dbus.packages = [ pkgs.gnome3.dconf ];
    udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
  };
  environment.systemPackages = with pkgs; [
    gnome3.gnome-tweak-tool
    gnomeExtensions.no-title-bar
  ];
}
