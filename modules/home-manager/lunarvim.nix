{ pkgs, ... }:

{
  home.packages = with pkgs; [
    lunarvim
    # Install Missing Packages
    rust-analyzer
    python311Packages.pynvim
    lua-language-server
  ];

  home.file.".config/lvim/config.lua".text = builtins.readFile ./lvim/config.lua;
}

