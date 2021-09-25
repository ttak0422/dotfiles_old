{ config, pkgs, lib, ... }:
let dotnet-tool-path = "${config.home.homeDirectory}/.dotnet/tools";
in {
  home = {
    packages = with pkgs; [ dotnet-sdk_5 mono ];
    sessionVariables = { PATH = "$PATH:${dotnet-tool-path}"; };
  };
}
