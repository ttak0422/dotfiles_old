{ config, pkgs, lib, ... }:
let
  openChrome = pkgs.writeScriptBin "openChrome" ''
    #!/usr/bin/osascript
    tell application "Google Chrome"
      make new window
    end tell
  '';
in { home.packages = if pkgs.stdenv.isDarwin then [ openChrome ] else [ ]; }
