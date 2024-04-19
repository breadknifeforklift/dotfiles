# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, device, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ../../modules/system.nix
      ../../modules/firefox.nix
      ../../modules/audio.nix
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kelsier"; # Define your hostname.
  
  boot.initrd = {
    luks.devices.nixenc = {
      crypttabExtraOpts = [ "fido2-device=auto" ];
      device = "/dev/disk/by-partlabel/nixenc";
    };
    systemd.enable = true;
  };
  
  # reset / at each boot
  # boot.initrd = {
  #   enable = true;
  #   supportedFilesystems = [ "btrfs" ];
  #   systemd.enable = lib.mkDefault true;

  #   systemd.services.restore-root = let
  #   root-rollback = pkgs.writeScript "root-rollback" (builtins.readFile ./scripts/echo-test.sh);
  #   in
  #   {
  #     description = "Rollback btrfs rootfs";
  #     wantedBy = [ "initrd.target" ];
  #     after = [
  #       "systemd-cryptsetup@nixenc.service"
  #     ];
  #     before = [ "sysroot.mount" ];
  #     unitConfig.DefaultDependencies = "no";
  #     serviceConfig.Type = "oneshot";
  #     script = "${root-rollback}";
  #   };
  # };
  # boot.initrd.systemd.services.persisted-files = {
  #   description = "Hard-link persisted files from /persist";
  #   wantedBy = [
  #     "initrd.target"
  #   ];
  #   after = [
  #     "sysroot.mount"
  #   ];
  #   unitConfig.DefaultDependencies = "no";
  #   serviceConfig.Type = "oneshot";
  #   script = ''
  #     mkdir -p /sysroot/etc/
  #     ln -snfT /persist/system/etc/machine-id /sysroot/etc/machine-id
  #   '';
  # };

  # fileSystems."/persist".neededForBoot = true;
  # # configure impermanence
  # environment.persistence."/persist/system" = {
  #   directories = [
  #     "/etc/nixos"
  #     "/etc/NetworkManager/system-connections"
  #     "/var/lib/bluetooth"
  #   ];
  #   files = [
  #   ];
  # };


  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

