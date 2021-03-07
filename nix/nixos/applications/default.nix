{ config, pkgs, lib, ... }: {
  imports = [ ./jetbrains ./vscode ];
  environment.systemPackages = with pkgs; [
    google-chrome
    termite
    slack
    typora
  ];
}
