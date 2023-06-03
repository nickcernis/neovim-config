return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      require("tokyonight").setup({
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = false },
          keywords = { italic = false },
        },
        on_colors = function(colors)
          colors.comment = "#747fb3" -- Original about "#575f86".
        end,
      })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },

  -- Gruvbox: the best theme if you like brown.
  -- {
  --   "ellisonleao/gruvbox.nvim",
  --   lazy = false,    -- Load  during startup.
  --   priority = 1000, -- Load before other start plugins.
  --   config = function()
  --     require("gruvbox").setup({
  --       italic = {
  --         strings = false,
  --         comments = false,
  --         operators = false,
  --         folds = false,
  --       },
  --       bold = false,
  --       contrast = "hard",
  --     })
  --     vim.cmd("colorscheme gruvbox")
  --
  --     -- Theme overrides.
  --     -- Give the color column less contrast.
  --     vim.cmd([[highlight ColorColumn guibg=#242729]])
  --   end,
  -- },

  -- Adds indentation guides.
  -- https://github.com/lukas-reineke/indent-blankline.nvim
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      -- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#363433 gui=nocombine]]
      require("indent_blankline").setup({
        char = "┊",
        show_end_of_line = true,
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
        show_trailing_blankline_indent = false,
        char_highlight_list = {
          "IndentBlanklineIndent1",
          "IndentBlanklineIndent2",
          "IndentBlanklineIndent3",
          "IndentBlanklineIndent4",
          "IndentBlanklineIndent5",
          "IndentBlanklineIndent6",
        },
      })
    end,
  },
}
