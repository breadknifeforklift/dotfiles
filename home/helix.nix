{ pkgs, config, lib, ... }:
{
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
      themes = {
        custppuccin = {
          inherits = "catppuccin_macchiato";
          palette = {
            base = "#272c35";
            mantle = "#21242c";
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
  };
}
