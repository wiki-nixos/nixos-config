{ config, pkgs, ... }:

{
  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
    enable = true;
  };
}