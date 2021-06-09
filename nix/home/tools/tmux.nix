{ config, pkgs, lib, ... }:

with lib;

let
  sources = import ./../../sources.nix;
  defaultShell = "${pkgs.zsh}/bin/zsh";
  statusInterval = 60;
  resizeAmount = 5;
  lStatusSimbol = "\\ue0b1";
  rStatusSimbol = "\\ue0b3";
  colors = {
    accent = "yellow";
    statusLeft = "cyan";
    statusRight = "#da3e39";
    termBg = "#fafafa";
    termFg = "#494b53";
  };
  plugins = with pkgs; [
    {
      plugin = tmuxPlugins.resurrect;
      extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    }
    {
      plugin = tmuxPlugins.continuum;
      extraConfig = ''
        # https://github.com/tmux-plugins/tmux-continuum/blob/master/docs/automatic_start.md
        # set -g @continuum-boot 'on'
        set -g @continuum-save-interval '5' # minutes
        set -g @continuum-restore 'on'
      '';
    }
    {
      plugin = tmuxPlugins.mkTmuxPlugin {
        name = "tmux-better-mouse-mode";
        pluginName = "tmux-better-mouse-mode";
        src = sources."tmux-better-mouse-mode";
      };
      extraConfig = ''
        set-option -g mouse on
      '';
    }
    #    {
    #      plugin = tmuxPlugins.mkTmuxPlugin {
    #        name = "tmux-prefix-highlight";
    #        pluginName = "tmux-prefix-highlight";
    #        src = sources."tmux-prefix-highlight";
    #      };
    #      extraConfig = ''
    #        set -g @prefix_highlight_show_copy_mode 'on'
    #        set -g @prefix_highlight_show_sync_mode 'on'
    #        set -g @prefix_highlight_fg 'white'
    #        set -g @prefix_highlight_bg 'blue'
    #        set -g @prefix_highlight_empty_attr 'fg=default,bg=green'
    #        set -g @prefix_highlight_copy_mode_attr 'fg=black,bg=yellow,bold'
    #        set -g @prefix_highlight_sync_mode_attr 'fg=black,bg=green'
    #
    #        set -g @prefix_highlight_empty_prompt '    '
    #        set -g @prefix_highlight_prefix_prompt 'Wait'
    #        set -g @prefix_highlight_copy_prompt 'Copy'
    #        set -g @prefix_highlight_sync_prompt 'Sync'
    #        set -g @prefix_highlight_output_prefix ' '
    #        set -g @prefix_highlight_output_suffix ' '
    #      '';
    #    }
    { plugin = tmuxPlugins.yank; }
    { plugin = tmuxPlugins.open; }
    { plugin = tmuxPlugins.copycat; }
    {
      plugin = tmuxPlugins.jump;
      extraConfig = ''
        set -g @jump-key 'Space'
      '';
    }
  ];
  shebang = ''
    #!${pkgs.bash}/bin/bash
  '';
  scriptDefinitions = {
    TMUX_LOA = ''
      uptime | awk -F "[:,]"  '{printf "LOA:%s %s %s\n",$(NF - 2),$(NF - 1), $NF}'
    '';
    TMUX_SINGLE_PANE = ''
      num=`tmux list-panes | wc -l`;
      if [[ 1 = $num ]]; then
        echo 0;
      else
        echo 1;
      fi
    '';
    TMUX_BORDER_UPDATE = ''
      zoomed=''${1:-0}
      num=`tmux list-panes | wc -l`;
      if [[ 1 = $num || 1 = $zoomed ]]; then
        tmux set pane-border-status off
      else
        tmux set pane-border-status top
      fi
    '';
    # WIP
    # TMUX_BORDER_UPDATEではPainが2つの時に片方を削除しても設定が反映されなかったため削除向けに
    TMUX_BORDER_UPDATE2 = ''
      tmux kill-pane
      num=`tmux list-panes | wc -l`;
      if [[ 1 = $num ]]; then
        tmux set pane-border-status off
      else
        tmux set pane-border-status top
      fi
    '';
  };
  scripts = builtins.mapAttrs (k: v: pkgs.writeScriptBin k (shebang + v))
    scriptDefinitions;
  scriptPackages = lib.mapAttrsToList (k: v: v) scripts;
  borderUpdate = ''
    run-shell "${scripts.TMUX_BORDER_UPDATE}/bin/TMUX_BORDER_UPDATE #{window_zoomed_flag}"'';
  borderUpdate2 =
    ''run-shell "${scripts.TMUX_BORDER_UPDATE2}/bin/TMUX_BORDER_UPDATE2"'';
  extraConfig = ''
    set-option -ga terminal-overrides ",screen-256color:Tc"
    set-option -g bell-action none 
    set-option -g renumber-windows on
    set-option -g status-interval ${toString statusInterval}

    bind c new-window\; ${borderUpdate}
    bind d detach-client
    bind : command-prompt
    bind [ copy-mode
    bind ] paste-buffer
    bind t clock-mode
    bind w choose-window
    bind s choose-session
    bind z resize-pane -Z\; ${borderUpdate}

    bind C-n command-prompt -I "" "new -s '%%'"

    # select-window
    bind 1 select-window -t :1
    bind 2 select-window -t :2
    bind 3 select-window -t :3
    bind 4 select-window -t :4
    bind 5 select-window -t :5
    bind 6 select-window -t :6
    bind 7 select-window -t :7
    bind 8 select-window -t :8
    bind 9 select-window -t :9
    bind 0 select-window -t :10

    # rename
    bind W command-prompt -I "#W" "rename-window '%%'"
    bind S command-prompt -I "#S" "rename-session '%%'"
    bind P command-prompt -I "#T" "select-pane -T '%%'"

    # close 
    bind x confirm-before -p "kill-pane #W? (y/n)" "${borderUpdate2}"
    bind X confirm-before -p "kill-window #W? (y/n)" "${borderUpdate2}"

    # move-window
    bind -r , previous-window
    bind -r . next-window 

    # move-pane
    bind -r h select-pane -L
    bind -r j select-pane -D
    bind -r k select-pane -U
    bind -r l select-pane -R

    # resize-pane
    bind -r H resize-pane -L ${toString resizeAmount}
    bind -r J resize-pane -D ${toString resizeAmount}
    bind -r K resize-pane -U ${toString resizeAmount}
    bind -r L resize-pane -R ${toString resizeAmount}

    # swap-windw
    bind -r < \
    swap-window -t -1\; \
      previous-window
    bind -r > \
    swap-window -t +1\; \
      next-window

    # split pane
    bind | split-window -h -c '#{pane_current_path}'\; ${borderUpdate}
    bind - split-window -v -c '#{pane_current_path}'\; ${borderUpdate}

    # status
    set -g status-left-length 40
    set -g status-right-length 80

    # color
    set -g status-style fg=${colors.termFg},bg=${colors.termBg}
    set -g message-style fg=${colors.accent},reverse,bg=default

    # status-left
    set -g status-left "#[fg=${colors.statusLeft}]SESSION: #S ${lStatusSimbol} #{?window_zoomed_flag,ZOOM ${lStatusSimbol},}"

    # status-center
    set-option -g status-justify "centre"
    set-window-option -g window-status-format " #I:#W "
    set-window-option -g window-status-current-format "#[reverse] #I:#W #[default]"

    # status-right
    set -g status-right "#[fg=${colors.statusRight}]${rStatusSimbol} #(${scripts.TMUX_LOA}/bin/TMUX_LOA) ${rStatusSimbol} TIME: %H:%M "

    # border
    set -g pane-active-border-style ""
    set -g pane-border-style ""
    set -g pane-border-format "#{?client_prefix,#[fg=${colors.termBg}]#[bg=${colors.accent}],#[fg=${colors.termBg}]#[bg=${colors.termFg}]}#{?pane_active, #P:#T ,}"
    set -g pane-border-status top

    # default shell
    set-option -g default-shell "${defaultShell}"
    set -g default-command "${defaultShell}"
  '';
in {
  programs.zsh.enable = true;
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    shortcut = "a";
    keyMode = "vi";
    customPaneNavigationAndResize = false; # select-paneにrオプションが無いため
    newSession = true;
    escapeTime = 1;
    baseIndex = 1;
    resizeAmount = 10;
    historyLimit = 5000;
    plugins = plugins;
    extraConfig = extraConfig;
    terminal = "screen-256color";
  };
  home.packages = scriptPackages;
}
