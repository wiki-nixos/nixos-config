{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  nur,
  ...
}: let
  # Import the scripts from the specified path
  scripts = builtins.attrValues (import ../../modules/home-manager/scripts.nix {inherit pkgs;});
in {
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    outputs.homeManagerModules.git
    outputs.homeManagerModules.kitty
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.firefox
    outputs.homeManagerModules.btop
    outputs.homeManagerModules.dunst
    outputs.homeManagerModules.gtk
    outputs.homeManagerModules.qt
    outputs.homeManagerModules.hyprland
    outputs.homeManagerModules.waybar
    outputs.homeManagerModules.wlogout
    outputs.homeManagerModules.swaylock
    outputs.homeManagerModules.swayidle
    outputs.homeManagerModules.swappy
    outputs.homeManagerModules.cmus
    outputs.homeManagerModules.tmux
    outputs.homeManagerModules.starship
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "eternal";
    homeDirectory = "/home/eternal";
  };

  home.packages = with pkgs;
    [
      dconf
    ]
    ++ scripts;

  services.cliphist.enable = true;

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
