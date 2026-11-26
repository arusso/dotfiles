-- miser.nvim: wires LSPs, formatters and tasks from the tools declared in
-- mise.toml (requires nvim >= 0.11 and mise on PATH).
return {
  {
    "carldaws/miser.nvim",
    config = function()
      require("miser").setup({
        -- format-on-save.nvim (plugins/formatting.lua) already formats on save;
        -- leaving this on would format twice.
        auto_format = false,
      })
    end,
  },
}
