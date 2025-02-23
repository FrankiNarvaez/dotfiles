return {
  -- Plugin for the Kanagawa color scheme
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  priority = 1000, -- High priority to ensure it loads early
  opts = {
    transparent = true, -- Enable transparent background
    theme = "dragon", -- Set the theme variant to 'dragon'
  },
  config = function()
    vim.cmd.colorscheme "kanagawa-dragon"
  end
}
