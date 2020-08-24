{ config, pkgs, lib, ... }: {
  home.stateVersion = "20.03";
  imports = [ ./generic ];
  home.file.".profile".text = lib.mkAfter ''
    # nix
    source ~/.nix-profile/etc/profile.d/nix.sh
  '';
  home.sessionVariables = {
    TMUX_TMPDIR = "/tmp";
  };
}
