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
    EDITOR = "hx";
    VISUAL = "hx";
  };
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec{
      modifier = "Mod4";
      terminal = "wezterm";
      menu = "wofi --show drun --allow-images";
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
    wofi = {
      enable = true;
      settings = {
        gtk_dark = true;
      };
    };
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
    helix = {
      enable = true;
      defaultEditor = true;
      themes = {
        custppuccin = {
          inherits = "catppuccin_macchiato";
          palette = {
            base = "#272c35";
            mantle = "21242c";
            crust = "#1a1c23";
            cursorline = "#343941";
          };
        };
      };
      settings = {
        theme = "custppuccin";
        editor = {
          mouse = false;
          line-number = "relative";
          cursorline = true;
          lsp = {
            display-messages = true;
            auto-signature-help = true;
            display-inlay-hints = true;
          };
          indent-guides = {
            character = "┆";
            render = true;
          };
        };
      };
    };
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
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
