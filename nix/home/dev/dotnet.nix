{ config, pkgs, lib, ... }:
let dotnet-tool-path = "${config.home.homeDirectory}/.dotnet/tools";
in {
  home = {
    packages = with pkgs;
      [
        (with dotnetCorePackages; combinePackages [ dotnet-sdk_3 dotnet-sdk_5 ])
      ];
  };
}
