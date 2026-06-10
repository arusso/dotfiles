local is_nvim_lt_10 = vim.fn.has("nvim-0.10") == 0

return {
  {
    'elentok/format-on-save.nvim',
    commit = is_nvim_lt_10 and "718ed51" or nil,
    lazy = false,
    config = function()
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
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.8", -- Compatible with Neovim 0.7+
    config = function()
      require("indent_blankline").setup {
        char = "┊",
        show_trailing_blankline_indent = false,
        show_current_context = true,
        show_current_context_start = true,
        context_patterns = {
          "class", "function", "method", "block", "list_literal", "selector",
          "^if", "^table", "if_statement", "while", "for"
        },
      }
    end
  },
}
