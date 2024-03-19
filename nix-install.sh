#!/bin/sh

curl https://raw.githubusercontent.com/breadknifeforklift/nixos-config/main/disko.nix -o /tmp/disko.nix

# List the disks and ask the user to select one
echo "Available disks:"
lsblk
read -p "Enter the device you want to use (e.g., xvda): " device

# ask user for password for disk encryption and primary user
read -p "Enter a password for the primary user: " password
echo -n "$password" > /tmp/secret.key

# Run disko to format and mount partitions
sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"$device"'

# set user password
sudo mkdir /mnt/persist/passwords
sudo mkpasswd -m sha-512 "$password" > /mnt/persist/passwords/stephan

# Generate hardware-configuration.nix
sudo nixos-generate-config --no-filesystems --root /mnt

# Initialize flake
pushd /mnt/etc/nixos
sudo rm -f configuration.nix
sudo nix --extra-experimental-features "nix-command flakes" flake init --template github:breadknifeforklift/nixos-config

sudo find flake.nix -type f -exec sed -i "s|device = \"sda\";|device = \"$device\";|g" {} \;

# Install NixOS
nixos-install --root /mnt --flake /mnt/etc/nixos#nixos

# Reboot system
sudo reboot