{ config, pkgs, callPackage, lib, ... }:


{
  imports =
    [ 
      ./hardware-configuration.nix
      <home-manager/nixos>      
#      ./../../nixpkgs/user/tak.nix
#      ./../../nixpkgs/git/index.nix
#      ./../../nixpkgs/terminal/tmux.nix
#      ./../../nixpkgs/terminal/fish.nix
#      ./../../nixpkgs/terminal/bash.nix
#      ./../../nixpkgs/wip/peco.nix
    ];
  # programs.home-manager.enable = true;
  home-manager.users.tak = (import ./home.nix);
#  programs.home-manager.enable = true;
 # # home-manager.stateVersion = "20.03";
  # for bash
  # home-manager.file.".profile".text = lib.mkAfter ". $HOME/.nix-profile/etc/profile.d/nix.sh";
  # https://wiki.archlinux.jp/index.php/Fish
  # home-manager.file.".bashrc".text = lib.mkAfter "exec fish";
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    # this does not work as expected.
    # other nameserver is added.
    # nameservers = [ "8.8.8.8" "8.8.4.4" ];
    useDHCP = false;
    interfaces.wlp2s0.useDHCP = true;
  };

  environment.etc = {
    "resolv.conf".text = "nameserver 8.8.8.8\nnameserver 8.8.4.4";
  };
  environment.pathsToLink = ["/libexec"];

  fonts = {
    fonts = with pkgs; [
      dejavu_fonts
      ipafont
    ];
    fontconfig = {
      # ultimate.enable = true;
      defaultFonts = {
        monospace = [
          "DejaVu Sans Mono"
          "IPAGothic"
        ];
        sansSerif = [
          "DejaVu Sans"
          "IPAGothic"
        ];
        serif = [
          "DejaVu Serif"
          "IPAGothic"
        ];
      };
    };
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keymap = "us";
  # };
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
    wget vim firefox bat git screenfetch vscode tig tmux docker-compose slack neofetch google-chrome
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
    gnome3 = {
      gnome-keyring.enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      # gnome
      # displayManager.gdm.enable = true;
      # desktopManager.gnome3.enable = true;
      
      # i3
      desktopManager = {
        xterm.enable = false;
      };
      displayManager = {
       defaultSession = "none+i3";
      };
      windowManager.i3 = { 
        enable = true;
        extraPackages = with pkgs; [
          rofi
	  i3status
        ];
        #   demu
        #   i3status
        #   i3lock
        #   i3blocks
        # ];
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

