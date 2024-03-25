{ pkgs, inputs, ... }:

{ 
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.persistence."/persist/home" = {
    directories = [
    ];
    files = [
    ];
    allowOther = true;
  };

  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    nerdfonts
  ];

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = pkgs.lib.readFile ./programs/sway.config;
  };

  programs = {
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
          font = wezterm.font 'Fira Code'
          font_size = 14.0,
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