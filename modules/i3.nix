{ config, pkgs, ... }:
{
  services.xserver = {
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
    };
  };

  environment.systemPackages = with pkgs; [
    i3status dmenu rofi picom feh lxappearance
  ];
}
