{ config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "20.09";
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  home.sessionVariables = { TMUX_TMPDIR = "/tmp"; };
}
