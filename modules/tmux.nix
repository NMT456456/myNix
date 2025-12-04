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

  home.file.".config/tmux/tmux.conf".text = ''
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
    bind r source-file ~/.tmux.conf

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
    set -g @theme_transparent_status_bar 'true'
    set -g @theme_plugin_datetime_format '%d/%m/%Y'

    # tpm plugin
    set -g @plugin 'tmux-plugins/tpm'

    # list of tmux plugins
    set -g @plugin 'tmux-plugins/tmux-sensible'
    set -g @plugin 'christoomey/vim-tmux-navigator'
    set -g @plugin 'catppuccin/tmux#v2.1.3'
    # set -g @plugin 'fabioluciano/tmux-tokyo-night'
    set -g @plugin 'tmux-plugins/tmux-resurrect' # persist tmux sessions after computer restart
    set -g @plugin 'tmux-plugins/tmux-continuum' # automatically saves sessions for you every 15 minutes


    set -g @resurrect-capture-pane-contents 'on'
    set -g @continuum-restore 'on'
    set -g @continuum-boot 'on'

    #Configure the catppuccin plugin
    set -g @catppuccin_date_time_text " %d/%m/%Y"
    set -g @catppuccin_flavor "mocha"


    #Left Status
    set -g status-left-length 100
    set -g status-left "#{E:@catppuccin_status_session}"

    #Right
    set -g status-right-length 100
    set -g status-right "#{E:@catppuccin_status_directory}"
    set -ag status-right "#{E:@catppuccin_status_uptime}"
    set -ag status-right "#{E:@catppuccin_status_date_time}"


    #Panes setting
    # set -g @catppuccin_pane_status_enabled "yes" # set to "yes" to enable
    # set -g @catppuccin_pane_border_status "yes" # set to "yes" to enable
    # set -g @catppuccin_pane_border_style "fg=#{@thm_overlay_0}"
    # set -g @catppuccin_pane_active_border_style "##{?pane_in_mode,fg=#{@thm_lavender},##{?pane_synchronized,fg=#{@thm_mauve},fg=#{@thm_lavender}}}"
    # set -g @catppuccin_pane_left_separator "█"
    # set -g @catppuccin_pane_middle_separator "█"
    # set -g @catppuccin_pane_right_separator "█"
    # set -g @catppuccin_pane_color "#{@thm_green}"
    # set -g @catppuccin_pane_background_color "#{@thm_surface_0}"
    # set -g @catppuccin_pane_default_text "##{b:pane_current_path}"
    # set -g @catppuccin_pane_default_fill "number"
    # set -g @catppuccin_pane_number_position "left" # right, left

    #Windows
    set -g @catppuccin_window_status_style "basic" # basic, rounded, slanted, custom, or none
    set -g @catppuccin_window_text_color "#{@thm_surface_0}"
    set -g @catppuccin_window_number_color "#{@thm_overlay_2}"
    set -g @catppuccin_window_text " #W"
    set -g @catppuccin_window_number "#I"
    set -g @catppuccin_window_current_text_color "#{@thm_surface_1}"
    set -g @catppuccin_window_current_number_color "#{@thm_mauve}"
    set -g @catppuccin_window_current_text " #W"
    set -g @catppuccin_window_current_number "#I"
    set -g @catppuccin_window_number_position "left"
    set -g @catppuccin_window_flags "icon" # none, icon, or text
    set -g @catppuccin_window_flags_icon_current " " # *
    set -g @catppuccin_window_flags_icon_last " " # -
    set -g @catppuccin_window_flags_icon_zoom " " # Z
    set -g @catppuccin_window_flags_icon_mark " " # M
    set -g @catppuccin_window_flags_icon_silent " " # ~
    set -g @catppuccin_window_flags_icon_activity " " # #
    set -g @catppuccin_window_flags_icon_bell " " # !
    #Matches icon order when using `#F` (`#!~[*-]MZ`)
    set -g @catppuccin_window_flags_icon_format "##{?window_activity_flag,#{E:@catppuccin_window_flags_icon_activity},}##{?window_bell_flag,#{E:@catppuccin_window_flags_icon_bell},}##{?window_silence_flag,#{E:@catppuccin_window_flags_icon_silent},}##{?window_active,#{E:@catppuccin_window_flags_icon_current},}##{?window_last_flag,#{E:@catppuccin_window_flags_icon_last},}##{?window_marked_flag,#{E:@catppuccin_window_flags_icon_mark},}##{?window_zoomed_flag,#{E:@catppuccin_window_flags_icon_zoom},} "

    #Status
    set -g @catppuccin_status_background 'none'
    set -g @catppuccin_status_left_separator " "
    set -g @catppuccin_status_middle_separator ""
    set -g @catppuccin_status_right_separator " "
    set -g @catppuccin_status_connect_separator "no" # yes, no
    set -g @catppuccin_status_fill "icon"
    set -g @catppuccin_status_module_bg_color "#{@thm_surface_0}"

    # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    # run ~/.config/tmux/plugins/tmux/catppuccin.tmux
    run '~/.config/tmux/plugins/tpm/tpm'
  '';
}
