{ config, callPackage, pkgs, ... }:

let sources = import ./../../nix/sources.nix;
in {
  imports = [
    ./hardware-configuration.nix
    ./../../networking
    ./../../virtualisation
    ./../../language
    ./../../services/xserver
    ./../../services/picom.nix
    ./../../services/tlp.nix
    ./../../utils
    ./../../gui
    ./../../gui/jetbrains.nix
    ./../../cui
    ./../../android
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "jp106";
  };
  nixpkgs.config.pulseaudio = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  environment.systemPackages = with pkgs; [
    linuxPackages.tp_smapi
    home-manager
  ];

  services.xserver = {
    libinput.enable = true;
    # synaptics.enable = true;

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
    extraGroups = [ "wheel" "docker" "adbusers" ];
  };

  system.stateVersion = "20.03";
}

