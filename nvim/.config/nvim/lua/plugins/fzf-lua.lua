return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function()
    -- Setup fzf-lua
    local fzf_lua = require("fzf-lua")
    vim.keymap.set('n', '<leader><leader>', fzf_lua.files, { noremap = true, silent = true, desc = 'Search...' })
    vim.keymap.set('n', '<leader>sg', fzf_lua.live_grep, { noremap = true, silent = true, desc = 'Search...' })
  end
}

