# interactive filtering tool
{ config, pkgs, lib, ... }:

let
  config = ''
    {
      "keymap": {
        "C-j": "peco.SelectDown",
        "C-k": "peco.SelectUp",
        "C-f": "peco.ScrollPageDown",
        "C-b": "peco.ScrollPageUp"
      }
    }
  '';
in {
  home.packages = [ pkgs.peco ];
  home.file.".config/peco/config.json".text = config;
}
