-- This file contains the configuration for various Neovim plugins related to the editor.

return {
  {
    -- Plugin: git.nvim
    -- URL: https://github.com/dinhhuy258/git.nvim
    -- Description: Provides Git integration for Neovim.
    "dinhhuy258/git.nvim",
    event = "BufReadPre", -- Load the plugin before reading a buffer
    opts = {
      keymaps = {
        blame = "<Leader>gb", -- Keybinding to open blame window
        browse = "<Leader>go", -- Keybinding to open file/folder in git repository
      },
    },
  },
}
