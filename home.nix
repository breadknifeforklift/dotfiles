{ pkgs, inputs, lib, ... }:

{ 
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  # home.persistence."/persist/home" = {
  #   directories = [
  #   ];
  #   files = [
  #   ];
  #   allowOther = true;
  # };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
    nvim-pkg
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec{
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "wofi --show drun";
      output."*" = {
	  bg = "#272c35 solid_color";
      };
      window.titlebar = false;
      fonts = {
        names = [ "FiraCode Nerd Font" ];
	size = 12.0;
      };
      keybindings = lib.mkOptionDefault { 
        "${modifier}+Shift+e" = "exec swaymsg exit";
      };
      startup = [
        { command = "wezterm"; }
      ];
    };
  };

  programs = {
    fish = {
      enable = true;
      shellAliases = {
        vim = "nvim";
        vi = "nvim";
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
    wofi.enable = true;
    git = {
      enable = true;
      userName = "breadknifeforklift";
      userEmail = "breadknifeforklift@proton.me";
    };
    firefox = {
      enable = true;
      profiles = {
        default = {
          id = 0;
          name = "default";
          isDefault = true;
          settings = {
            "browser.search.defaultenginename" = "DuckDuckGo";
            "browser.search.order.1" = "DuckDuckGo";
          };
          search = {
            force = true;
            default = "DuckDuckGo";
            order = [ "DuckDuckGo" "Google" ];
          };
        };
      };
    };
    # neovim = {
    #   enable = true;
    #   defaultEditor = true;
    #   package = pkgs.nvim-pkg;
    #   viAlias = true;
    #   vimAlias = true;
    #   vimdiffAlias = true;
    # };
    wezterm = {
      enable = true;
      extraConfig = ''
        local custom = wezterm.color.get_builtin_schemes()["Catppuccin Macchiato"];
        custom.background = "#272c35";
        
        return {
          color_schemes = {
            [ "Custppuccin" ] = custom,
          },
          font = wezterm.font 'FiraCode Nerd Font',
          font_size = 12.0,
          color_scheme = "Custppuccin",
          enable_tab_bar = false,
          term = "wezterm",
          keys = {
            {
              key = "t",
              mods = "SUPER",
              action = wezterm.action.DisableDefaultAssignment,
            },
          },
        }
      '';
    };
  };
}
