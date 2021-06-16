{ config, pkgs, lib, ... }: {
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
  system.defaults.NSGlobalDomain = {
    NSAutomaticDashSubstitutionEnabled = false;
    ApplePressAndHoldEnabled = false;
  };
}
