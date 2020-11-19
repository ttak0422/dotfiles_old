{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ zsh-powerlevel10k ];
  programs.zsh = {
    enable = true;
    initExtra = ''
      test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"
      # test -e "/etc/static/bashrc" && source "/etc/static/bashrc"
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
    '';
    profileExtra = ''
      [[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
    '';
  };
}
