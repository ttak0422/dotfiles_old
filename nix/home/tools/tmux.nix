{ config, pkgs, lib, ... }:

with lib;

let
  sources = import ./../../sources.nix;
  defaultShell = "${pkgs.zsh}/bin/zsh";
  statusInterval = 60;
  resizeAmount = 5;
  lSimbol = "\\ue0b0";
  lSimbol' = "\\ue0b1";
  rSimbol = "\\ue0b2";
  rSimbol' = "\\ue0b3";
  colors = {
    accent = "yellow";
    character = "white";
    statusLeft = "cyan";
    statusRight = "red";
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
      # TODO:
      # plugin = tmuxPlugins.mkTmuxPlugin {
        plugin = tmuxPlugins.mkDerivation {
          name = "tmux-better-mouse-mode";
          pluginName = "tmux-better-mouse-mode";
          src = sources."tmux-better-mouse-mode";
        };
        extraConfig = ''
          set-option -g mouse on
        '';
      }
#     { 
#       # TODO:
#       # plugin = tmuxPlugins.mkTmuxPlugin {
#       plugin = tmuxPlugins.mkDerivation {
#         name = "tmux-power";
#         pluginName = "tmux-power";
#         rtpFilePath = "tmux-power.tmux";
#         src = sources."tmux-power";
#       };
#       extraConfig = ''
#         set -g @tmux_power_theme 'snow'
#         set -g @tmux_power_date_icon ' ' # set it to a blank will disable the icon
#         set -g @tmux_power_time_icon ' ' # emoji can be used if your terminal supports
#         set -g @tmux_power_user_icon 'U'
#         set -g @tmux_power_session_icon 'S'
#         set -g @tmux_power_upload_speed_icon 
#       '';
#     }
#     { 
#       plugin = tmuxPlugins.prefix-highlight;
#       extraConfig = ''
#       '';
#     }
#     {
#       plugin = tmuxPlugins.mkDerivation {
#         name = "web-reachable";
#         pluginName = "web-reachable";
#         rtpFilePath = "web-reachable.tmux";
#         src = sources."tmux-web-reachable";
#       };
#       extraConfig = ''
#         set -g @tmux_power_show_web_reachable true
#       '';
#     }
  ];
  extraConfig = ''
    set-option -ga terminal-overrides ",screen-256color:Tc"
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

    # rename
    bind W command-prompt -I "#W" "rename-window '%%'"
    bind S command-prompt -I "#S" "rename-session '%%'"

    # close 
    bind x confirm-before -p "kill-pane #W? (y/n)" kill-pane
    bind X confirm-before -p "kill-window #W? (y/n)" kill-window

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
    bind | split-window -h -c '#{pane_current_path}'
    bind - split-window -v -c '#{pane_current_path}'

    # status
    set -g status-left-length 40
    set -g status-right-length 80

    # color
    set -g status-style fg=default,bg=default
    set -g message-style fg=${colors.accent},reverse,bg=default

    # left
    set -g status-left "#[fg=${colors.character},bg=${colors.statusLeft}]#{?client_prefix,#[fg=${colors.character}]#[bg=${colors.accent}],} Session: #S #[default]#[fg=${colors.statusLeft}]#{?client_prefix,#[fg=${colors.accent}],}${lSimbol}"

    # center
    set-option -g status-justify "centre"
    set-window-option -g window-status-format " #I:#W "
    set-window-option -g window-status-current-format "#[default, reverse] #I:#W #[default]"

    # right
    set -g status-right "#[fg=${colors.statusRight}]${rSimbol}#[fg=${colors.character},bg=${colors.statusRight}] %H:%M #[default]"

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
}
