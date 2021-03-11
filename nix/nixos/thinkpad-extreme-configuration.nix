# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./applications
    ./language
    ./networking
    ./services
    ./virtualization
    ./utils/tlp.nix
    ./thinkpad-extreme-hardware.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp0s20f3.useDHCP = true;
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # 4K
  hardware.video.hidpi.enable = true;
  environment.variables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.xserver = {
    libinput.enable = true;
    config = ''
      Section "InputClass"
        Identifier     "Enable libinput for TrackPoint"
        MatchIsPointer "on"
        Driver         "libinput"
        Option         "ScrollMethod" "button"
        Option         "ScrollButton" "8"
      EndSection
    '';
  };

  users.users.tak = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [ linuxPackages.tp_smapi ];

  system.stateVersion = "20.09";

  time.timeZone = "Asia/Tokyo";
}

