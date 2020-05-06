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
  home.file.".config/peco/config.json".text = config;
}
