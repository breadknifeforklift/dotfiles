if vim.g.did_load_plugins_plugin then
  return
end
vim.g.did_load_plugins_plugin = true

-- many plugins annoyingly require a call to a 'setup' function to be loaded,
-- even with default configs

require('nvim-surround').setup()
require('which-key').setup()

require("catppuccin").setup {
  color_overrides = {
    macchiato = {
      base = "#272c35",
      mantle = "#21242c",
      crust = "#1a1c23",
    },
  }
}

vim.cmd.colorscheme "catppuccin-macchiato"