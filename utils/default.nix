{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Asia/Tokyo";
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  environment.pathsToLink = [ "/libexec" ];
}
