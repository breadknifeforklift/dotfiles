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
          color_scheme = "Custppuccin",
          hide_tab_bar_if_only_one_tab = true,
        }
      '';
    };
  };
}