return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Setup treesitter
    local config = require("nvim-treesitter.configs")
    config.setup({
      ensure_isntalled = { "lua", "javascript" },
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}

