{ config, pkgs, lib, ... }:
let
  chrome = pkgs.writeScriptBin "chrome" ''
    #!/usr/bin/osascript
    tell application "Google Chrome"
      make new window
    end tell
  '';
in { home.packages = if pkgs.stdenv.isDarwin then [ chrome ] else [ ]; }
