-- nvim-treesitter (main branch): parser installer/manager. Needs nvim >= 0.11,
-- the tree-sitter CLI (mise) and a C compiler. Highlighting is started per
-- buffer below; the plugin itself no longer does that.
local parsers = {
  "bash", "diff", "dockerfile", "git_config", "gitcommit", "gitignore", "go",
  "gomod", "gosum", "hcl", "html", "json", "lua", "markdown",
  "markdown_inline", "python", "query", "ruby", "rust", "terraform", "toml",
  "vim", "vimdoc", "yaml",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(parsers)

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          -- silently skip filetypes without an installed parser
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
