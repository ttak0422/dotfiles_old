{ config, pkgs, lib, ... }:
let
  sources = import ./../../../nix/sources.nix;
  shared = import ./shared.nix {
    pkgs = pkgs;
    shell-type = "zsh";
  };
in {
  home.packages = with pkgs; [ zsh-powerlevel10k ];
  programs.zsh = {
    enable = true;
    defaultKeymap = "viins";
    # memo
    # prompt_charの変更はp10kで可能
    # typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='$fg[blue]❯'
    # typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='$fg[green]CMD ❯'
    # typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='$fg[magenta]VIS ❯'
    initExtra = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      [[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
      # Instant prompt
      # zshrcの更新を反映するにはzwcの削除が必要
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # abbrs
      source ${sources.zsh-abbrev-alias}/abbrev-alias.plugin.zsh
      ${lib.strings.concatStringsSep "\n" (builtins.attrValues
        (lib.attrsets.mapAttrs (k: v: ''abbrev-alias -g ${k}="${v}"'')
          shared.abbrevs.static))}
      ${lib.strings.concatStringsSep "\n" (builtins.attrValues
        (lib.attrsets.mapAttrs (k: v: ''abbrev-alias -ge ${k}="${v}"'')
          shared.abbrevs.eval))}

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

      # https://unix.stackexchange.com/questions/368231/going-over-start-of-insert-action-in-z-shell-vi-mode
      bindkey -M viins '^?' backward-delete-char
      bindkey -M viins '^H' backward-delete-char
      
      # https://qiita.com/ssh0/items/a9956a74bff8254a606a
      if [[ ! -n $TMUX ]]; then
        # get the IDs
        ID="`tmux list-sessions`"
        if [[ -z "$ID" ]]; then
          tmux new-session
        fi
        create_new_session="Create New Session"
        ID="$ID\n''${create_new_session}:"
        ID="`echo $ID | peco | cut -d: -f1`"
        if [[ "$ID" = "''${create_new_session}" ]]; then
          tmux new-session
        elif [[ -n "$ID" ]]; then
          tmux attach-session -t "$ID"
        else
          :  # Start terminal normally
        fi
      fi

    '';
    shellAliases = shared.shellAliases;
    profileExtra = "";
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
      {
        name = "zsh-vimode-visual";
        src = sources.zsh-vimode-visual;
      }
    ];

  };
}
