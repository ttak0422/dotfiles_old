{ config, pkgs, lib, ... }: {
  home.packages = with pkgs; [ zsh-powerlevel10k ];
  programs.zsh = {
    enable = true;
    initExtra = ''
      test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"
      # test -e "/etc/static/bashrc" && source "/etc/static/bashrc"
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      [[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
    '';
    shellAliases = {
      "g" = "cd (ghq root)'/'(ghq list | peco)";
      "gh" = ''hub browse (ghq list | peco | cut -d "/" -f 2,3)'';
      "gg" = "ghq get";
      "c" = "xclip -selection clipboard";
    };
    profileExtra = ''
    '';
  };
}
