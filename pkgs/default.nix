# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'

{pkgs, ...}: {
  # example = pkgs.callPackage ./example { };
  sddm-theme = pkgs.callPackage ./sddm-theme.nix { };
  cmus-notify = pkgs.callPackage ./cmus-notify.nix { };
  vecx = pkgs.callPackage ./vecx.nix { };
  birch = pkgs.callPackage ./birch.nix { };
}
