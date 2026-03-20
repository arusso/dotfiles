local opt = vim.opt

vim.g.mapleader = '-'
vim.g.maplocalleader = "\\"

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
