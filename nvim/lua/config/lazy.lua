-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = {}
  },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    }
  }
}
local opts = {}

require("lazy").setup(plugins, opts)  

-- Setup colorscheme
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

-- Setup fzf-lua
local fzf_lua = require("fzf-lua")
vim.keymap.set('n', '<leader><leader>', fzf_lua.files, { noremap = true, silent = true, desc = 'Search...' })
vim.keymap.set('n', '<leader>sg', fzf_lua.live_grep, { noremap = true, silent = true, desc = 'Search...' })

-- Setup treesitter
local config = require("nvim-treesitter.configs")
config.setup({
  ensure_isntalled = { "lua", "javascript" },
  highlight = { enable = true },
  indent = { enable = true }
})

-- Setup neo-tree
vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left<CR>', {})
