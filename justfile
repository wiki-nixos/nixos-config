# run disko
disko path:
	sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko {{path}}

# format
format:
	nix fmt .

# Passkey for the encrypted partition
luks-key password:
  sudo echo -n "{{password}}" > /tmp/secret.key

# install NixOS
install host:
	sudo nixos-install --flake .#{{host}}
