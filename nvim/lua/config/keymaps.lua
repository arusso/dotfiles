-- clear search highlight with a space
vim.keymap.set('n', '<space>', ':noh<cr>', { silent = true })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic" })
