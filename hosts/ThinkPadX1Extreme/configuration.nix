# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let 
  sources = import ./../../nix/sources.nix;
in {
  imports =
    [ 
      ./hardware-configuration.nix
      "${sources.home-manager}/nixos"
      ./../../networking
      ./../../virtualisation
      ./../../language
      ./../../services/xserver
      ./../../services/picom.nix
      ./../../utils
      ./../../gui
      ./../../cui
    ];

  home-manager.users.tak = { ... }: {
    imports = [ 
      ./../../home/generic 
      ./../../home/nixos
      ];

  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  
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
    extraGroups = [ "wheel" "docker" ];
  };

  system.stateVersion = "20.03"; 

}

