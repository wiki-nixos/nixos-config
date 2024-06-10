#
# Install Stuff
#

# Passkey for the encrypted partition
# DO THIS BEFORE DISKO
luks-key password:
        sudo echo -n "{{password}}" > /tmp/secret.key

# run disko
disko path:
        sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko {{path}}

# Move config to /mnt/etc/nixos
move-config:
        sudo cp -r * .git /mnt/etc/nixos

# Generate hardware-configuration.nix
generate-hardware host:
        sudo nixos-generate-config --root /mnt
        sudo rm /mnt/etc/nixos/configuration.nix
        sudo mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/nixos/{{host}}/

# install NixOS
install host:
        sudo nixos-install --flake .#{{host}}

#
# General Commands
#

# Format Files
format:
        nix fmt .

# Rebuild
rebuild host:
        sudo nixos-rebuild switch --flake .#{{host}}
