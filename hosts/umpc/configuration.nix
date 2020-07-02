{ config, pkgs, callPackage, lib, ... }:

{
  imports = [ ./hardware-configuration.nix <home-manager/nixos> ];
  home-manager.users.tak = (import ./home.nix);
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    useDHCP = false;
    interfaces.wlp2s0.useDHCP = true;
  };

  environment.etc = {
    "resolv.conf".text = ''
      nameserver 8.8.8.8
      nameserver 8.8.4.4'';
  };
  environment.pathsToLink = [ "/libexec" ];

  fonts = {
    fonts = with pkgs; [ dejavu_fonts ipafont ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "DejaVu Sans Mono" "IPAGothic" ];
        sansSerif = [ "DejaVu Sans" "IPAGothic" ];
        serif = [ "DejaVu Serif" "IPAGothic" ];
      };
    };
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx";
      fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
    };
  };

  time.timeZone = "Asia/Tokyo";

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    vim
    firefox
    bat
    git
    screenfetch
    vscode
    tig
    tmux
    docker-compose
    slack
    neofetch
    google-chrome
    home-manager
  ];

  virtualisation = {
    docker = {
      enable = true;
      enableOnBoot = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;

  programs = {
    seahorse.enable = true;
    gnome-terminal.enable = true;
  };

  services = {
    gnome3 = { gnome-keyring.enable = true; };
    xserver = {
      enable = true;
      layout = "us";

      # i3
      desktopManager = { xterm.enable = false; };
      displayManager = { defaultSession = "none+i3"; };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [ rofi i3status ];
      };
    };
  };

  users.users.tak = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "docker" ];
  };

  system.stateVersion = "20.03";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

}

