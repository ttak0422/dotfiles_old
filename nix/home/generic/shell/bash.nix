{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ bashInteractive_5 bash-completion powerline-go ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      function _update_ps1_a() {
        PS1="$($HOME/.nix-profile/bin/powerline-go -error $? -modules cwd,perms,git,hg,jobs,exit,root -cwd-mode dironly)"
      }
      function _update_ps1_b() {
        PS1="$(/run/current-system/sw/bin/powerline-go -error $? -modules cwd,perms,git,hg,jobs,exit,root -cwd-mode dironly)"
      }
      if [ -f "$HOME/.nix-profile/bin/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1_a; $PROMPT_COMMAND"
      elif [ -f "/run/current-system/sw/bin/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1_b; $PROMPT_COMMAND"
      fi
    '';
  };
  home.file.".bashrc".text = lib.mkAfter ''
    . ${pkgs.bash-completion}/share/bash-completion/bash_completion
  '';
}
