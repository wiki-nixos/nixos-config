# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  nixvim,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    outputs.nixosModules.plymouth
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      eternal = import ../../home-manager/eternal/home.nix;
    };
  };

  nixpkgs = {
    config = {
      allowUnfree = true; # Allow unfree packages

      # Override packages with NUR repository
      packageOverrides = pkgs: {
        nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
          inherit pkgs;
        };
      };
    };

    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];
  };

  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  nix = {
    # Add each flake input as a registry to make nix3 commands consistent with your flake
    registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

    # Add your inputs to the system's legacy channels, making legacy nix commands consistent as well
    nixPath = ["/etc/nix/path"];
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
      extra-substituters = ["https://cache.lix.systems"];
      trusted-public-keys = ["cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Bootloader
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        efiSupport = true;
        device = "nodev";
      };
    };
    kernelPackages = pkgs.linuxPackages_zen;
  };

  # Configure NM and Hostname
  networking = {
    hostName = "xps";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Australia/Sydney";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Configure X / Wayland
  services.xserver = {
    enable = true;

    # Use the Novideo driver
    videoDrivers = ["intel"];

    # Configure keymap
    xkb = {
      layout = "au";
      variant = "";
    };

    # Exclude Xterm
    excludePackages = with pkgs; [xterm];
  };

  services.displayManager = {
    # Configure SDDM with custom theme.
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "${import ../../pkgs/sddm-theme.nix {inherit pkgs;}}"; # Scuffed?
    };
    sessionPackages = [pkgs.hyprland];
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # Enable sound with pipewire.
  sound.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable Bluetooth on Boot
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # Enable the Z Shell
  programs.zsh.enable = true;

  # Dconf for home-manager
  programs.dconf.enable = true;

  # Use micro instead of nano
  programs.nano.enable = false;

  # Define my user account
  users.users.eternal = {
    isNormalUser = true;
    description = "Default User";
    extraGroups = ["networkmanager" "wheel" "audio" "video" "plugdev" "cdrom"];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # Main Apps
      vesktop
      samba
      fastfetch
      transmission #-gtk
      tgpt
      krabby
      pavucontrol
      xfce.thunar
      blueman
      spotify-player
      imv
      mpv
      cmus-notify
      birch
      eza
      micro
      inputs.nixvim.packages."x86_64-linux".default # Custom Nixvim Config

      # Hyprland Dependancys
      waybar
      swww
      bibata-cursors
      polkit_gnome
      rofi-wayland
      wl-clipboard
      slurp
      grim
      swayidle
      jq
      yad
      activate-linux
      hyprpicker
    ];
  };

  # List packages installed in system profile. To search, run:
  # nix search wget
  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    font-awesome
    noto-fonts-emoji
    cifs-utils
  ];

  # Configure Nerd Fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
  ];

  # Mount my servers Samba share
  fileSystems."/mnt/samba_share" = {
    device = "//192.168.50.52/samba-share";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=/etc/nixos/secrets/smb-secrets"];
  };

  # Start polkit-gnome on boot
  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # GVFS For mounting other drives
  services.gvfs.enable = true;

  # Session Management
  services.dbus.enable = true;

  # Security
  services.gnome.gnome-keyring.enable = true;
  services.tumbler.enable = true;
  security.pam.services.swaylock = {};
  security.polkit.enable = true;

  # Configure XDG
  xdg = {
    portal = {
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
