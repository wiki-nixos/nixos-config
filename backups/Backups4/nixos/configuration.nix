# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    ../modules/nixos/bootloader/grub.nix
    ../modules/nixos/hostname/hostname.nix
    ../modules/nixos/networking/wireless.nix
    ../modules/nixos/networking/networkmanager.nix
    ../modules/nixos/networking/proxy.nix
    ../modules/nixos/networking/firewall.nix
    ../modules/nixos/time/time.nix
    ../modules/nixos/locale/locale.nix
    ../modules/nixos/hostname/hostname.nix
    ../modules/nixos/audio/pipewire/pipewire.nix
    ../modules/nixos/bluetooth/bluetooth.nix
    ../modules/nixos/desktop/kde/plasma5.nix
    ../modules/nixos/desktop/sddm/sddm.nix
    ../modules/nixos/desktop/xserver/xserver.nix
    ../modules/nixos/users/eternal/eternal.nix
    ../modules/nixos/touchpad/libinput.nix
    ../modules/nixos/system/system-packages.nix
    ../modules/nixos/ssh/openssh.nix
    ../modules/nixos/print/print.nix
    ../modules/nixos/home-manager/home-manager.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = {
      # Import your home-manager configuration
      eternal = import ../home-manager/home.nix;
    };
  };

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
    };
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };
}
