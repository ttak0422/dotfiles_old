{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.programs.tmux;
  defaultShell = "${pkgs.zsh}/bin/zsh";
  statusInterval = 60;
  lSimbol = "\\ue0b0";
  lSimbol' = "\\ue0b1";
  rSimbol = "\\ue0b2";
  rSimbol' = "\\ue0b3";
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
  ];
  extraConfig = ''
    set-option -g bell-action none 
    set-option -g renumber-windows on
    set-option -g status-interval ${toString statusInterval}

    bind c new-window
    bind d detach-client
    bind : command-prompt
    bind [ copy-mode
    bind ] paste-buffer
    bind t clock-mode
    bind w choose-window
    bind s choose-session
    bind z resize-pane -Z   

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
    bind -r h next-window
    bind -r l previous-window

    # rename
    bind W command-prompt -I "#W" "rename-window '%%'"
    bind S command-prompt -I "#S" "rename-session '%%'"

    # close 
    bind x confirm-before -p "kill-pane #W? (y/n)" kill-pane
    bind X confirm-before -p "kill-window #W? (y/n)" kill-window

    # window swap
    bind -r C-h \
      swap-window -t -1\; \
      previous-window
    bind -r C-l \
      swap-window -t +1\; \
      next-window

    # split pane
    bind | split-window -h -c '#{pane_current_path}'
    bind - split-window -v -c '#{pane_current_path}'

    # status
    set -g status-left-length 40
    set -g status-right-length 80

    # color
    set -g status-style fg=default,bg=default
    set -g message-style fg=green,reverse,bg=default

    # left
    set -g status-left "#[fg=white,bg=blue]#{?client_prefix,#[fg=black]#[bg=yellow],} Session: #S #[default]#[fg=blue]#{?client_prefix,#[fg=yellow],}${lSimbol}"

    # center
    set-option -g status-justify "centre"
    set-window-option -g window-status-format " #I:#W "
    set-window-option -g window-status-current-format "#[fg=white]#[default]#[fg=black,bg=white] #I:#W #[default]#[fg=white]#[default]"

    # right
    set -g status-right "#[fg=red]${rSimbol}#[default]#[fg=white,bg=red] %H:%M #[default]"

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
    customPaneNavigationAndResize = true;
    newSession = true;
    escapeTime = 1;
    baseIndex = 1;
    resizeAmount = 10;
    historyLimit = 5000;
    plugins = plugins;
    extraConfig = extraConfig;
    terminal = "screen-256color";
  };
}
