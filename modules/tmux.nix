{ inputs, config, pkgs, ... }:

{
  home.file.".config/tmux/plugins/tpm" = {
    source = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tpm";
      rev = "master";
      sha256 = "sha256-hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
    };
  };

  programs.tmux = {
    enable = true;
    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"

      set -g prefix C-z
      unbind C-b
      bind-key C-z send-prefix

      unbind %
      bind | split-window -h 

      unbind '"'
      bind - split-window -v

      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      bind j resize-pane -D 5
      bind k resize-pane -U 5
      bind l resize-pane -R 5
      bind h resize-pane -L 5

      bind -r m resize-pane -Z

      bind M-c attach-session -c "#{pane_current_path}"

      set -g mouse on

      set-window-option -g mode-keys vi

      bind-key -T copy-mode-vi 'v' send -X begin-selection # start selecting text with "v"
      bind-key -T copy-mode-vi 'y' send -X copy-selection # copy text with "y"

      unbind -T copy-mode-vi MouseDragEnd1Pane # don't exit copy mode when dragging with mouse

      # remove delay for exiting insert mode with ESC in Neovim
      set -sg escape-time 10

      set -g base-index 1
      set -g pane-base-index 1
      set-option -g status-position top
      set -g status-style "bg=#{@thm_bg}"
      set -g status-justify "absolute-centre"

      # tpm plugin
      set -g @plugin 'tmux-plugins/tpm'

      # list of tmux plugins
      # set -g @plugin 'fabioluciano/tmux-tokyo-night'
      set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'tmux-plugins/tmux-online-status'
      set -g @plugin 'tmux-plugins/tmux-resurrect' # persist tmux sessions after computer restart
      set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes
      set -g @plugin 'christoomey/vim-tmux-navigator'
      set -g @plugin 'catppuccin/tmux'


      set -g @resurrect-capture-pane-contents 'off'
      set -g @continuum-restore 'on'
      # set -g @continuum-systemd-start-cmd 'new-session -d'
      # set -g @continuum-boot 'on'

      # Configure Catppuccin
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_status_background "none"
      set -g @catppuccin_window_status_style "none"
      set -g @catppuccin_pane_status_enabled "off"
      set -g @catppuccin_pane_border_status "off"

      # Configure Online
      set -g @online_icon "ok"
      set -g @offline_icon "nok"

      # status left look and feel
      set -g status-left-length 100
      set -g status-left ""
      set -ga status-left "#{?client_prefix,#{#[bg=#{@thm_red},fg=#{@thm_bg},bold]  #S },#{#[bg=default,fg=#{@thm_green}]  #S }}"
      set -ga status-left "#[bg=default,fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[bg=default,fg=#{@thm_maroon}]  #{pane_current_command} "
      set -ga status-left "#[bg=default,fg=#{@thm_overlay_0},none]│"
      set -ga status-left "#[bg=default,fg=#{@thm_blue}]  #{=/-32/...:#{s|$USER|~|:#{b:pane_current_path}}} "
      set -ga status-left "#[bg=default,fg=#{@thm_overlay_0},none]#{?window_zoomed_flag,│,}"
      set -ga status-left "#[bg=default,fg=#{@thm_yellow}]#{?window_zoomed_flag,  zoom ,}"

      # status right look and feel
      set -g status-right-length 100
      set -g status-right ""
      # set -ga status-right "#{?#{e|>=:10,#{battery_percentage}},#{#[bg=#{@thm_red},fg=#{@thm_bg}]},#{#[bg=#{@thm_bg},fg=#{@thm_pink}]}} #{battery_icon} #{battery_percentage} "
      # set -ga status-right "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}, none]│"
      # set -ga status-right "#[bg=default]#{?#{==:#{online_status},ok},#[fg=#{@thm_mauve}] 󰖩 on ,#[fg=#{@thm_red},bold]#[reverse] 󰖪 off }"
      set -ga status-right "#[bg=default]#{?#{==:#{online_status},ok},#[fg=#{@thm_mauve}] 󰖩 on ,#[fg=#{@thm_red}]#[reverse] 󰖪 off }"
      set -ga status-right "#[bg=default,fg=#{@thm_overlay_0}, none]│"
      set -ga status-right "#[bg=default,fg=#{@thm_blue}] 󰭦 %d-%m-%Y 󰅐 %H:%M "

      # pane border look and feel
      setw -g pane-border-status top
      setw -g pane-border-format ""
      setw -g pane-active-border-style "bg=default,fg=#{@thm_overlay_0}"
      setw -g pane-border-style "bg=default,fg=#{@thm_surface_0}"
      setw -g pane-border-lines single

      # window look and feel
      set -wg automatic-rename on
      set -g automatic-rename-format "Window"

      set -g window-status-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-style "bg=default,fg=#{@thm_rosewater}"
      set -g window-status-last-style "bg=default,fg=#{@thm_peach}"
      set -g window-status-activity-style "bg=#{@thm_red},fg=#{@thm_bg}"
      set -g window-status-bell-style "bg=#{@thm_red},fg=#{@thm_bg},bold"
      set -gF window-status-separator "#[bg=#{@thm_bg},fg=#{@thm_overlay_0}]│"

      set -g window-status-current-format " #I#{?#{!=:#{window_name},Window},: #W,} "
      set -g window-status-current-style "bg=#{@thm_peach},fg=#{@thm_bg},bold"

      # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
      run '~/.config/tmux/plugins/tpm/tpm'
    '';
  };
}
