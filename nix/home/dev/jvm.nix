{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ adoptopenjdk-jre-openj9-bin-13 maven ];
}
