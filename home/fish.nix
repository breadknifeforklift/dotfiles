{ pkgs, config, lib, ... }:
{
  programs = {
  	fish = {
      enable = true;
      shellAliases = {
        vim = "hx";
        vi = "hx";
      };
      functions = {
        fish_greeting = {
          description = "fish shell greeting";
          body = "";
        };
      };
    };
    eza = {
      enable = true;
      enableFishIntegration = true;
      git = true;
      icons = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
    bat.enable = true;
    lf = {
      enable = true;
      previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!/bin/sh
      bat --color always "$@"
      '';
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
