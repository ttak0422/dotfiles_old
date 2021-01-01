{ config, pkgs, lib, ... }: {
  home.stateVersion = "20.09";
  home.username = builtins.getEnv "USER";
  home.homeDirectory = builtins.getEnv "HOME";
  imports = [ ./generic ];
  home.file.".profile".text = lib.mkAfter ''
    # nix
    source ~/.nix-profile/etc/profile.d/nix.sh
  '';
  home.sessionVariables = { TMUX_TMPDIR = "/tmp"; };
  nixpkgs.config.allowUnfree = true;
}
