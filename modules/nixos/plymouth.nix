{
  pkgs,
  config,
  lib,
  ...
}: {
  boot.initrd.systemd.enable = true; # This is needed to show the plymouth login screen to unlock luks
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };
}
