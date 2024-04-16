{ config, pkgs, inputs, nixpkgs, version, ... }:

{
 config = {
    nix = {
      package = pkgs.nixFlakes;
      extraOptions = ''
        experimental-features = nix-command flakes
      '';
    };

    nixpkgs.config.allowUnfree = true;

    system.stateVersion = "23.11";
 };
}