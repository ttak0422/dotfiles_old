{ config, pkgs, lib, ... }: 
{ 
  home.packages = with pkgs; [ powerline-go ];
  programs.bash = { 
    enable = true; 
    bashrcExtra = ''
      function _update_ps1_a() {
        PS1="$($HOME/.nix-profile/bin/powerline-go -error $?)"
      }
      function _update_ps1_b() {
        PS1="$(/run/current-system/sw/bin/powerline-go -error $?)"
      }
      if [ -f "$HOME/.nix-profile/bin/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1_a; $PROMPT_COMMAND"
      elif [ -f "/run/current-system/sw/bin/powerline-go" ]; then
        PROMPT_COMMAND="_update_ps1_b; $PROMPT_COMMAND"
      fi
    '';
  }; 
}
