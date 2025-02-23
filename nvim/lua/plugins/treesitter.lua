return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- Setup treesitter
    local config = require("nvim-treesitter.configs")
    config.setup({
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true }
    })
  end
}

