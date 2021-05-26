{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ dotnet-sdk_3 mono6 ];
}
