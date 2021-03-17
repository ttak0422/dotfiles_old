{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ dotnet-sdk_5 mono6 ];
}
