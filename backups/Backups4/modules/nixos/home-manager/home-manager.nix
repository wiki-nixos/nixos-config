{ config, pkgs, inputs, ... }:

{
  home-manager = {
  # also pass inputs to home-manager modules
  extraSpecialArgs = {inherit inputs;};
  users = {
     "eternal" = import ../../home.nix;
   };
 };
}