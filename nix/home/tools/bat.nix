# cat clone
{ config, pkgs, lib, ... }:

let config' = "";
in {
  home = {
    packages = [ pkgs.bat ];
    file.".config/bat/config".text = config';
  };
}
