return {
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup()
    end
  },
  {
    'numToStr/Comment.nvim',
    opts = {
      padding = true,
    },
  },
}
