{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    firefox
    google-chrome
    vscode
    termite
    slack
    teams
  ];
}
