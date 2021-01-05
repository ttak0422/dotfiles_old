{ config, pkgs, lib, ... }:

with lib;

let
  defaultShell = "${pkgs.bashInteractive_5}/bin/bash";
  cfg = config.programs.tmux;
  plugins = with pkgs; [
    tmuxPlugins.sidebar
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
    # unbind last-window
    unbind C-a

    # reorder window numbers.
    bind r                                      \
        set -g renumber-windows on\;            \
        new-window\; kill-window\;              \
        set -g renumber-windows off\;           \
        display-message "reordered..."

    # close window = prefix + shift + x
    bind X confirm-before -p 'kill-window #I? (y/n)' kill-window

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
    set -g status-left "#[fg=white,bg=blue]#{?client_prefix,#[bg=yellow],} Session: #S #[default]#[fg=blue]#{?client_prefix,#[fg=yellow],}"

    # center
    set-option -g status-justify "centre"
    set-window-option -g window-status-format " #I: #W "
    set-window-option -g window-status-current-format "#[fg=black,bg=white] #I: #W #[default]"

    # right
    set -g status-right "#[fg=red]#[default]#[fg=white,bg=red] #H #[default]"

    # default shell
    set-option -g default-shell "${defaultShell}"
    set -g default-command "${defaultShell}"
  '';
in {
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    escapeTime = 1;
    baseIndex = 1;
    shortcut = "a";
    customPaneNavigationAndResize = true;
    resizeAmount = 5;
    plugins = plugins;
    extraConfig = extraConfig;
  };
}
