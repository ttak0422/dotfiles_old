{ config, pkgs, lib, ... }: {
  services = if pkgs.stdenv.isLinux then { lorri.enable = true; } else { };
}
