return {
  "azorng/goose.nvim",
  config = function()
    require("goose").setup({
      default_global_keymaps = true, -- If false, disables all default global keymaps
      keymap = {
        global = {
          toggle = "<leader>tg", -- Open goose. Close if opened
          open_input = "<leader>ti", -- Opens and focuses on input window on insert mode
          open_input_new_session = "<leader>tI", -- Opens and focuses on input window on insert mode. Creates a new session
          open_output = "<leader>to", -- Opens and focuses on output window
          toggle_focus = "<leader>tt", -- Toggle focus between goose and last window
          close = "<leader>tq", -- Close UI windows
          toggle_fullscreen = "<leader>tf", -- Toggle between normal and fullscreen mode
          select_session = "<leader>ts", -- Select and load a goose session
          goose_mode_chat = "<leader>tmc", -- Set goose mode to `chat`. (Tool calling disabled. No editor context besides selections)
          goose_mode_auto = "<leader>tma", -- Set goose mode to `auto`. (Default mode with full agent capabilities)
          configure_provider = "<leader>tp", -- Quick provider and model switch from predefined list
          diff_open = "<leader>td", -- Opens a diff tab of a modified file since the last goose prompt
          diff_next = "<leader>t]", -- Navigate to next file diff
          diff_prev = "<leader>t[", -- Navigate to previous file diff
          diff_close = "<leader>tc", -- Close diff view tab and return to normal editing
          diff_revert_all = "<leader>tra", -- Revert all file changes since the last goose prompt
          diff_revert_this = "<leader>trt", -- Revert current file changes since the last goose prompt
        },
        window = {
          submit = "<cr>", -- Submit prompt (normal mode)
          submit_insert = "<cr>", -- Submit prompt (insert mode)
          close = "<esc>", -- Close UI windows
          stop = "<C-c>", -- Stop goose while it is running
          next_message = "]]", -- Navigate to next message in the conversation
          prev_message = "[[", -- Navigate to previous message in the conversation
          mention_file = "@", -- Pick a file and add to context. See File Mentions section
          toggle_pane = "<tab>", -- Toggle between input and output panes
          prev_prompt_history = "<up>", -- Navigate to previous prompt in history
          next_prompt_history = "<down>", -- Navigate to next prompt in history
        },
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
      },
    },
  },
}
