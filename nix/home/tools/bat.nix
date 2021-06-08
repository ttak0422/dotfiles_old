# cat clone
{ config, pkgs, lib, ... }:

let
  config' = ''
    --theme="OneHalfLight"
  '';
in {
  home = {
    packages = [ pkgs.bat ];
    file.".config/bat/config".text = config';
  };
}
