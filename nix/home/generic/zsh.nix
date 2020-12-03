{ config, pkgs, lib, ... }: 
let 
  sources = import ./../../nix/sources.nix;
  abbrevs = {
    static = {
      d = "docker";
      k = "kubectl";
      i = "istioctl";
      h = "helm";
      gc = "gcloud";
      dc = "docker-compose";
    };
    eval = {
    };
  };
in {
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

      # abbrs
      source ${sources.zsh-abbrev-alias}/abbrev-alias.plugin.zsh
      ${lib.strings.concatStringsSep "\n" (builtins.attrValues (lib.attrsets.mapAttrs (k: v: "abbrev-alias -g ${k}=\"${v}\"") abbrevs.static))}
      ${lib.strings.concatStringsSep "\n" (builtins.attrValues (lib.attrsets.mapAttrs (k: v: "abbrev-alias -ge ${k}=\"${v}\"") abbrevs.eval))}
      
      # https://qiita.com/reireias/items/fd96d67ccf1fdffb24ed
      # history
      HISTFILE=$HOME/.zsh-history
      HISTSIZE=100000
      SAVEHIST=1000000
      # share .zshhistory
      setopt inc_append_history
      setopt share_history
      function peco-history-selection() {
        BUFFER=`history -n 1 | tac  | awk '!a[$0]++' | peco`
        CURSOR=$#BUFFER
        zle reset-prompt
      }
      zle -N peco-history-selection
      bindkey '^R' peco-history-selection

      # kubectl
      source <(kubectl completion zsh)
    '';
    shellAliases = {
      "g" = "cd $(ghq root)/$(ghq list | peco)";
      "gh" = ''hub browse $(ghq list | peco | cut -d "/" -f 2,3)'';
      "gg" = "ghq get";
    };
    profileExtra = ''
    '';
    plugins = [
      { 
        name = "zsh-autosuggestions";
        src = sources.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = sources.zsh-syntax-highlighting;
      }
      {
        name = "zsh-abbrev-alias";
        src = sources.zsh-abbrev-alias;
      }
      {
        name = "zsh-256color";
        src = sources.zsh-256color;
      }
    ];

  };
}
