{ inputs, config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ ];
    };

    initContent = ''
      bindkey "^[[A" history-search-backward
      bindkey "^[[B" history-search-forward

      alias ls="eza -1 --icons=always"
      alias ll="eza -1 --icons=always -l -a"
      alias lst="eza --icons=always -T"
      alias llt="eza --icons=always -T -l -a"
      alias ffv='selected=$(fzf --style=full --preview="bat --color=always {}") && [ -n "$selected" ] && nvim "$selected"'
      alias cd="z"
      alias vi="nvim ."
      alias cf='cd "$(zoxide query -l | fzf --style=full)"'
      alias cl="clear"
      alias tx='tmux has-session -t main 2>/dev/null && tmux attach -t main || tmux'

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      export TERM=xterm-256color
      export COLORTERM=truecolor

      # tx() {
      #   local name="${"1:-main"}"
      #   if tmux has-session -t "$name" 2>/dev/null; then
      #       tmux attach -t "$name"
      #   else
      #       tmux
      #   fi
      # }


      [[ ! -f ~/.p10k.zsh ]] || source ~/hakiz-nix/dotfiles/.p10k.zsh

      eval "$(zoxide init zsh)"
    '';
  };
}
