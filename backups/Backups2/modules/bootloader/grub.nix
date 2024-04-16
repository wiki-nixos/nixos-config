{ config, pkgs, ... }:

{
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      efiSupport = true;
      # Uncomment the following line if canTouchEfiVariables doesn't work for your system
      # efiInstallAsRemovable = true;
      device = "nodev";
      theme  = grub/src/catppuccin-mocha-grub-theme;
      splashImage = null;
    };
  };
}
