{ inputs, config, pkgs, ... }:

{
  imports = [ ../modules/tmux.nix ../modules/zsh.nix ];

  home.username = "hakiz";
  home.homeDirectory = "/home/hakiz";
  home.stateVersion = "25.05";

  home.file.".config/nvim".source = ../dotfiles/nvim;

  programs.git = {
    enable = true;
    settings.user.name = "NMT456456";
    settings.user.email = "NMT456456@gmail.com";
  };

  home.packages = with pkgs; [
    home-manager
    neovim
    fastfetch
    git
    htop
    ripgrep
    bat
    gcc
    python314
    zsh-powerlevel10k
    zsh-autosuggestions
    zsh-syntax-highlighting
    eza
    fzf
    zoxide
    tree-sitter
    unzip
    cargo
    nodejs
    lazygit
  ];
}
