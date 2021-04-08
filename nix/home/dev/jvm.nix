{ config, pkgs, lib, ... }: { home.packages = with pkgs; [ jdk maven scala ]; }
