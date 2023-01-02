return {
  -- Status line.
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = false,
          -- theme = 'tokyonight',
          -- theme = 'onedark',
          component_separators = "|",
          section_separators = "",
        },
      })
    end,
  },
}
