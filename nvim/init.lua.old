-- Set the runtime path to include the ~/.vim directory
vim.cmd('set runtimepath^=~/.vim')

-- Set the packpath to be the same as the runtimepath
vim.o.packpath = vim.o.runtimepath

-- Source the ~/.vimrc file
vim.cmd('source ~/.vimrc')

-- install lazy if it's not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local version = vim.version()
local is_nvim_lt_10 = version.major < 1 and version.minor < 10

require("lazy").setup({
  spec = {
    {
      'elentok/format-on-save.nvim',
      commit = is_nvim_lt_10 and "718ed51" or nil,
    },
    {'f-person/git-blame.nvim',},
    {'rust-lang/rust.vim',},
    {'fatih/vim-go',},
    {'hashivim/vim-terraform',},
    {'hashivim/vim-vaultproject',},
    {'godlygeek/tabular',},
  },
})

-- format on save
-- This plugin is expecting any shell formatters to accept code on stdin and to
-- print to stdout. I think unless the language has it's own opinionated
-- formatter, I don't know that this safe to use.
local format_on_save = require("format-on-save")
local formatters = require("format-on-save.formatters")
format_on_save.setup({
    debug = false,
    exclude_path_patterns = {
        "/node_modules/",
        ".local/share/nvim/lazy",
    },
    formatter_by_ft = {
        html = formatters.lsp,
        json = formatters.lsp,
        lua = formatters.lsp,
        -- I think it will be a challenge to use this while collaborating with
        -- others on python code
        -- python = formatters.black,
        rust = formatters.lsp,
        yaml = formatters.lsp,
        -- special ones
        hcl = {
            formatters.shell({ cmd = { "packer", "fmt", "-" } })
        },
        go = {
            formatters.shell({ cmd = { "goimports" } }),
            formatters.shell({ cmd = { "gofmt" } }),
        },
        terraform = formatters.shell({ cmd = { "terraform", "fmt", "-" } }),
    },
})
