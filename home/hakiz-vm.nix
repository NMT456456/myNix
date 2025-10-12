{ config, pkgs, ... }:

{
  imports = [../modules/i3.nix];

  home.username = "hakiz";
  home.homeDirectory = "/home/hakiz";


  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    bat
    git
    open-vm-tools
    alacritty
  ];


  home.stateVersion = "25.05";
}
