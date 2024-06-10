# run disko
disko path:
	sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko {{path}}

# format
format:
	nix fmt .

# install NixOS
install host:
	sudo nixos-install --flake .#{{host}}
