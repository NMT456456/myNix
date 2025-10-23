{ inputs, config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ ];
    };

    siteFunctions = {
      vi = ''
        if [ $# -eq 0 ]; then
          nvim .
          return
        fi
        case "$1" in
          nix)
            cd ~/myNix && nvim .
            ;;
          null)
            nvim .
            ;;
          *)
            nvim "$@"
            ;;
        esac
      '';

      nixbuild = ''
        nix run ~/myNix#homeConfigurations.$1.activationPackage
      '';
    };

    shellAliases = {
      ffv =
        "selected=$(fzf --style=full --preview='bat --color=always {}') && [ -n '$selected' ] && nvim '$selected'";
      ls = "eza -1 --icons=always";
      ll = "eza -1 --icons=always -l -a";
      lst = "eza --icons=always -T";
      llt = "eza --icons=always -T -l -a";
      cd = "z";
      cf = "cd '$(zoxide query -l | fzf --style=full)'";
      cl = "clear";
      tx =
        "tmux has-session -t main 2>/dev/null && tmux attach -t main || tmux";
      lg = "lazygit";
    };

    initContent = ''
      bindkey "^[[A" history-search-backward
      bindkey "^[[B" history-search-forward

      #single-user nix
      . ~/.nix-profile/etc/profile.d/nix.sh
      #path for site-functions
      fpath=("$HOME/.nix-profile/share/zsh/site-functions" $fpath)

      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      export TERM=xterm-256color
      export COLORTERM=truecolor

      [[ ! -f ~/.p10k.zsh ]] || source ~/myNix/dotfiles/.p10k.zsh

      eval "$(zoxide init zsh)"
    '';
  };
}
