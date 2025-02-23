-- Oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- FzfLua
vim.keymap.set('n', '<C-p>', 'FzfLua files<CR>', { noremap = true, silent = true, desc = 'Search...' })
vim.keymap.set('n', '<leader>sg', 'FzfLua live_grep<CR>', { noremap = true, silent = true, desc = 'Search...' })

-- Telescope
vim.keymap.set('n', '<leader><leader>', 'Telescope find_files<CR>', {})
vim.keymap.set('n', '<leader>lg', 'Telescope live_grep<CR>', {})

-- lsp-config
vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
vim.keymap.set('n', 'gr', vim.lsp.buf.references, {})
vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

-- neo-tree
vim.keymap.set('n', '<leader>e', ':Neotree filesystem reveal left<CR>', {})

-- none_ls
vim.keymap.set('n', '<leader>fg', vim.lsp.buf.format, {})
