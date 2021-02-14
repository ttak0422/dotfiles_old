{ config, pkgs, lib, ... }: {
  imports = [ ./vscode ];
  environment.systemPackages = with pkgs; [
    google-chrome
    termite
    slack
    typora
  ];
}
