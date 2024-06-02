{
  config,
  lib,
  pkgs,
  ...
}: {
  qt = {
    enable = true;
    platformTheme = "gtk";
    style = {
      name = "catppuccin-mocha";
      package = pkgs.catppuccin-qt5ct;
    };
  };
}
