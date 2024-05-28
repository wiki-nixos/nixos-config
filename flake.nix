{
  description = "Eternal's Nix Flake";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nixpkgs Stable
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Chaotic
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # NUR
    nur.url = "github:nix-community/NUR";

    # Firefox Addons
    firefox-addons.url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";

    # Hyprland
    hyprland.url = "github:hyprwm/Hyprland";

    # Custom Nixvim Url
    nixvim.url = "github:eternalblissed/nixvim";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    home-manager,
    nixos-hardware,
    chaotic,
    nur,
    firefox-addons,
    hyprland,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems
    systems = [
      "x86_64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Custom Packages
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter, run with `nix fmt`
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules I might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules I might want to export
    # These are usually stuff I would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    nixosConfigurations = {
      "970-desktop" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # > Main NixOS configuration file <
          ./nixos/970-desktop/configuration.nix
          chaotic.nixosModules.default
          nur.nixosModules.nur
          nixos-hardware.nixosModules.common-cpu-intel-sandy-bridge
        ];
      };
    };
  };
}
