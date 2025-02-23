return {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
  config = function()
    -- Setup colorscheme
    vim.cmd.colorscheme "catppuccin"
  end
}

