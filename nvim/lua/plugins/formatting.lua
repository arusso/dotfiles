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
  }
}
