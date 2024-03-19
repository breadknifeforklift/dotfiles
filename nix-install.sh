#!/bin/sh

curl https://raw.githubusercontent.com/breadknifeforklift/nixos-config/main/disko.nix -O /tmp/disko.nix

# List the disks and ask the user to select one
echo "Available disks:"
lsblk
read -p "Enter the device you want to use (e.g., xvda): " device

# ask user for password for disk encryption and primary user
read -p "Enter a password for the primary user: " password
echo -n "$password" > /tmp/secret.key

# Run disko to format and mount partitions
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device '"$device"'

# set user password
sudo mkpasswd -m sha-512 "$password" > /mnt/persist/passwords/stephanecho -n "$password" > /tmp/secret.key

# Generate hardware-configuration.nix
sudo nixos-generate-config --no-filesystems --root /mnt

# Initialize flake
pushd /mnt/etc/nixos
nix flake init --template github.com:breadknifeforklift/nixos-config

sed 

# Install NixOS
nixos-install --root /mnt --flake /mnt/etc/nixos#nixos

# Reboot system
sudo reboot