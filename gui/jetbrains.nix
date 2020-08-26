{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    jetbrains.idea-ultimate
    jetbrains.goland
    jetbrains.rider
    jetbrains.clion
    jetbrains.webstorm
    jetbrains.pycharm-professional
    jetbrains.ruby-mine
  ];
}
