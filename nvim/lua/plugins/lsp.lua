-- lua/plugins/lsp.lua
-- Servers themselves are wired by miser.nvim (plugins/miser.lua) from the tools
-- in mise.toml; only helpers that aren't servers live here.
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
