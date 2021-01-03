{ config, pkgs, lib, ... }:
let
  sampleHello = pkgs.writeScriptBin "sampleHello" ''
    #!/usr/bin/env bash
    echo Hello
  '';

in { home.packages = [ sampleHello ]; }
