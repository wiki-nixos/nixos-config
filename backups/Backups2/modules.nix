# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, nixpkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan
      ./hardware-configuration.nix
      ./modules/nix/nix.nix
      ./modules/bootloader/grub.nix
      ./modules/hostname/hostname.nix
      ./modules/networking/wireless.nix
      ./modules/networking/networkmanager.nix
      ./modules/networking/proxy.nix
      ./modules/networking/firewall.nix
      ./modules/time/time.nix
      ./modules/locale/locale.nix
      ./modules/hostname/hostname.nix
      ./modules/audio/pipewire/pipewire.nix
      ./modules/bluetooth/bluetooth.nix
      ./modules/desktop/kde/plasma5.nix
      ./modules/desktop/sddm/sddm.nix
      ./modules/desktop/xserver/xserver.nix
      ./modules/users/eternal/eternal.nix
      ./modules/touchpad/libinput.nix
      ./modules/system/system-packages.nix
      ./modules/ssh/openssh.nix
      ./modules/print/print.nix
      ./modules/home-manager/home-manager.nix
      inputs.home-manager.nixosModules.default
    ];
}
