{ pkgs, config, lib, ...}:
{
  options.mod = lib.mkOption {
    type = lib.types.str;
    default = "Mod4";
    description = "The modifier key to use in sway. `Mod1` for Alt";
  };
  
  config = {
    wayland.windowManager.sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      config = rec{
        modifier = config.mod;
        terminal = "wezterm";
        menu = "wofi --show drun --allow-images";
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
        startup = [
          { command = "wezterm"; }
        ];
      };
    };
    programs = {
      wofi = {
        enable = true;
        settings = {
          gtk_dark = true;
        };
      };
    };
  };
}
