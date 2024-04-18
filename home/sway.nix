{ pkgs, config, lib, ...}:
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    config = rec{
      modifier = "Mod1";
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
    wofi = {
      enable = true;
      settings = {
        gtk_dark = true;
      };
    };
  };
}
