# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, device, ... }:

{
  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  system.autoUpgrade = {
    enable = true;
  };

  time.timeZone = "America/New_York";

  security.polkit.enable = true; # needed for Sway Home-Manager install

  programs.fuse.userAllowOther = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    marksman
    nil # nix lsp
  ];

  programs = {
    fish.enable = true;
    # since fish isn't POSIX compliant this is a
    # workaround to setting fish as default shell
    bash = {
      interactiveShellInit = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
        then
          shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
    };
  };
}

