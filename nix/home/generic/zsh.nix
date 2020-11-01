{ config, pkgs, lib, ... }: {
  programs.zsh = {
    enable = true;
    initExtra = ''
      test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"
      test -e "/etc/static/bashrc" && source "/etc/static/bashrc"
    '';
    profileExtra = ''
      [[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
    '';
  };
}
