{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ subversion ];
}
