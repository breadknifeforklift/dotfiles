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
        keys.normal = {
          C-j = [ "keep_primary_selection" "move_line_down" "extend_to_line_bounds" "extend_line_above" "split_selection_on_newline" "select_mode" "goto_line_end_newline" "normal_mode" "rotate_selection_contents_forward" "keep_primary_selection" "move_line_down" ];
          C-k = [ "keep_primary_selection" "extend_to_line_bounds" "extend_line_above" "split_selection_on_newline" "select_mode" "goto_line_end_newline" "normal_mode" "rotate_selection_contents_forward" "keep_primary_selection" ];
          C-g = [ ":new" ":insert-output lazygit" ":buffer-close!" ":redraw" ];
        };
      };
    };
  };
}
