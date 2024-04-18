{ pkgs, config, lib, ...}:
{
  programs = {
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
