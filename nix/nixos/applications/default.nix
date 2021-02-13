{ config, pkgs, lib, ... }: {
  environment.systemPackages =
    with pkgs; [ google-chrome vscode termite slack typora ];
}
