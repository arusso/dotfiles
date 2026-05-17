local opt = vim.opt

vim.g.mapleader = '-'
vim.g.maplocalleader = "\\"

-- disable netrw, setup termguicolors for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- turn on line numbers by default
opt.number = true

-- set indentation to use spaces instead of tabs
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- highlight search results
opt.hlsearch = true

-- use modeline
opt.modeline = true
opt.modelines = 4

opt.textwidth = 80
opt.colorcolumn = '80'

-- ansiblels only activates on the yaml.ansible filetype, not plain yaml.
-- Neovim won't automatically detect your Ansible files as yaml.ansible, so
-- you'll also want to add a filetype detection rule.
vim.filetype.add({
  pattern = {
    -- adjust these patterns to match your ansible file layout
    ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles/.*%.ya?ml'] = 'yaml.ansible',
    ['.*ansible.*%.ya?ml'] = 'yaml.ansible',
  },
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:append("t")
    vim.opt_local.formatoptions:remove("r") -- don't auto-insert comment leader on <Enter>
    vim.opt_local.formatoptions:remove("o") -- don't auto-insert comment leader on o/O
  end,
})

-- Highlight 81st character (yellow warning)
vim.api.nvim_set_hl(0, 'OverLength', { ctermbg = 'yellow', ctermfg = 'black', bg = '#7a6e00', fg = '#000000' })
vim.fn.matchadd('OverLength', '\\%81v.', -1)

-- Highlight 141st character (red hard limit)
vim.api.nvim_set_hl(0, 'OverLength140', { ctermbg = 'red', ctermfg = 'black', bg = '#592929' })
vim.fn.matchadd('OverLength140', '\\%141v.', -1)

-- Highlight trailing spaces
vim.api.nvim_set_hl(0, 'TrailingSpace', { ctermbg = 'red', ctermfg = 'black', bg = '#592929' })
vim.fn.matchadd('TrailingSpace', '\\s\\+$', -1)

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  callback = function()
    vim.fn.matchadd('OverLength', '\\%81v.', -1)
    vim.fn.matchadd('OverLength140', '\\%141v.', -1)
    vim.fn.matchadd('TrailingSpace', '\\s\\+$', -1)
  end,
})

opt.clipboard = 'unnamedplus'
