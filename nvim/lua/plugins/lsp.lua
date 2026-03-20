-- lua/plugins/lsp.lua
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
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            format = { enable = true },
            runtime = { version = 'LuaJIT' },
            diagnostics = { globals = { 'vim' } },
          },
        },
      })
      vim.lsp.enable('lua_ls')
    end,
  },
}
