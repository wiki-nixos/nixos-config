{
  config,
  lib,
  pkgs,
  ...
}: {
  qt = {
    enable = true;
    platformTheme = {
      name = "gtk";
    };
    style = {
      name = "catppuccin-mocha";
      package = pkgs.catppuccin-qt5ct;
    };
  };
}
