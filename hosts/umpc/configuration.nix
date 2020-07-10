{ config, pkgs, callPackage, lib, ... }:

let 
  sources = import ./../../nix/sources.nix;
in {
  imports = [
    ./hardware-configuration.nix
    "${sources.home-manager}/nixos"
  ];
  home-manager.useUserPackages = true;
  home-manager.useGlobalPkgs = true;
  home-manager.users.tak = { ... }: {
    programs.home-manager.enable = true;
    home.stateVersion = "20.03";
    imports = [ ./home.nix ];
  };

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
    fonts = with pkgs; [
      dejavu_fonts
      ipafont
      powerline-fonts
      # rofi
      fantasque-sans-mono
      iosevka
      noto-fonts-cjk
      comfortaa
      # (nerdfonts.override { withFont = "Hurmit";})
    ];
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
    # home-manager
    termite
    bmon
    ranger
    # polybar
    feh
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
    picom = {
      enable = true;
      shadow = true;
      # vSync = "opengl-swc";
      backend = "glx";
      # todo
      opacityRules = [
        "100:class_g = 'URxvt' && focused"
        "80:class_g = 'URxvt' && !focused"
      ];
      activeOpacity = "1.0";
      inactiveOpacity = "0.8";
      wintypes = {
        tooltip = {
          fade = true;
          shadow = false;
          opacity = "0.8";
        };
      };
      fadeDelta = 5;
      fadeSteps = [ "0.03" "0.03" ];
      fade = true;

      # extraOptions = ''  
      # '';
    };
    gnome3 = { gnome-keyring.enable = true; };
    xserver = {
      enable = true;
      layout = "us";

      # i3
      desktopManager = { xterm.enable = false; };
      displayManager = { defaultSession = "none+i3"; };
      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          rofi
          i3status
          i3lock
          papirus-icon-theme
          acpi
          xfce.xfce4-power-manager
        ];
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

