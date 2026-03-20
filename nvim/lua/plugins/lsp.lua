-- lua/plugins/lsp.lua
return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            format = { enable = true },
            runtime = {
              version = 'LuaJIT', -- Neovim uses LuaJIT
            },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file("", true), -- makes lua_ls aware of all Neovim runtime files
            },
            diagnostics = {
              globals = { 'vim' }, -- tell lua_ls vim is a valid global
            },
          },
        },
      })
      vim.lsp.enable('lua_ls')
    end,
  },
}
