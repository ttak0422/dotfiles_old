{ config, pkgs, lib, ... }:
let
  myPolyBarBattery = pkgs.writeScriptBin "myPolyBarBattery" ''
    #!/usr/bin/env bash

    capacity() {
      cat /sys/class/power_supply/BAT0/capacity \
      | xargs printf "%3s"

    }

    status() { 
      case `cat /sys/class/power_supply/BAT0/status` in 
      "Discharging") echo "" ;;
      "Charging") echo "" ;;
      "Unknown") echo "" ;;
      "Full") echo "" ;;
      * ) echo "?" ;;
      esac
    }

    printf "%s:%s" `status` `capacity`
  '';
in { environment.systemPackages = [ myPolyBarBattery ]; }
