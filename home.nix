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
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = rec{
      modifier = "Mod4";
      terminal = "wezterm";
      output."*" = {
	  bg = "#272c35 solid_color";
      };
      window.titlebar = false;
      fonts = {
        names = [ "FiraCode Nerd Font" ];
	size = 11.0;
      };
      keybindings = lib.mkOptionDefault { 
        "${modifier}+Shift+e" = "exec swaymsg exit";
      };
    };
  };

  programs = {
    fish = {
      enable = true;
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
    lf.enable = true;
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
    neovim = {
      enable = true;
      extraConfig = ''set number relativenumber'';
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
          font_size = 11.0,
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
