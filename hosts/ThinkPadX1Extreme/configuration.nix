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
    ./../../cui
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  environment.systemPackages = with pkgs; [
    linuxPackages.tp_smapi
    home-manager
    niv
    nixfmt
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
    extraGroups = [ "wheel" "docker" ];
  };

  system.stateVersion = "20.03";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.channel = https://nixos.org/channels/nixos-20.03;
  system.autoUpgrade.allowReboot = true;
}

