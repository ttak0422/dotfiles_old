{ config, pkgs, lib, ... }: { home.packages = with pkgs; [ jdk8 maven scala ]; }
