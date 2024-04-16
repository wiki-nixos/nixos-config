{ config, pkgs, ... }:

{
  # Enable the KDE Plasma Desktop Environment.
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.displayManager.defaultSession = "plasmawayland";

  # Exclude Packages
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    plasma-browser-integration
    konsole
    oxygen
    elisa
    gwenview
    kate
    kwrited
    okular
    spectacle
  ];
}