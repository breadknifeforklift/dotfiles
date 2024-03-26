#!/bin/sh

curl https://raw.githubusercontent.com/breadknifeforklift/dotfiles/main/disko.nix -o /tmp/disko.nix

# List the disks and ask the user to select one
echo "Available disks:"
lsblk
read -p "Enter the device you want to use (e.g., xvda): " device

# ask user for password for disk encryption and primary user
read -p "Enter a password for the primary user: " password
echo -n "$password" > /tmp/secret.key

# Run disko to format and mount partitions
sudo nix --extra-experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix --arg device "\"$device\""
# mount root subvolume and take a snapshot
sudo mkdir -p /mnt/root
sudo mount -o subvol=root /dev/mapper/root_vg-root /mnt/root
sudo btrfs subvolume snapshot -r /mnt/root /mnt/root-blank
sudo umount /mnt/root

# set user password
sudo mkdir /mnt/persist/passwords
sudo mkdir -p /mnt/persist/home/stephan/dotfiles
sudo mkdir /mnt/persist/system
echo -n "$password" | sudo mkpasswd -m sha-512 -s | sudo tee /mnt/persist/passwords/stephan > /dev/null


# Generate hardware-configuration.nix

# clone repo
git clone https://github.com/breadknifeforklift/dotfiles.git /mnt/home/stephan/dotfiles
sudo nixos-generate-config --no-filesystems --root /mnt --dir /mnt/home/stephan/dotfiles

pushd /mnt/home/stephan/dotfiles
git add hardware-configuration.nix
sudo find flake.nix -type f -exec sed -i "s|device = \"sda\";|device = \"$device\";|g" {} \;

# Install NixOS
sudo nixos-install --root /mnt --no-root-passwd --flake .

# Reboot system
# sudo reboot