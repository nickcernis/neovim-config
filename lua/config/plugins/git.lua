return {
  {
    -- Git signs in the gutter/signcolumn.
    -- Also adds ability to stage chunks, revert chunks, view inline diffs.
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        -- Prefer coloured lines over symbols.
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        keymaps = {
          noremap = true,

          ["n ]c"] = {
            expr = true,
            "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'",
          },
          ["n [c"] = {
            expr = true,
            "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'",
          },

          ["n <leader>hs"] = "<cmd>Gitsigns stage_hunk<CR>",
          ["v <leader>hs"] = ":Gitsigns stage_hunk<CR>",
          ["n <leader>hu"] = "<cmd>Gitsigns undo_stage_hunk<CR>",
          ["n <leader>hr"] = "<cmd>Gitsigns reset_hunk<CR>",
          ["v <leader>hr"] = ":Gitsigns reset_hunk<CR>",
          ["n <leader>hR"] = "<cmd>Gitsigns reset_buffer<CR>",
          ["n <leader>hp"] = "<cmd>Gitsigns preview_hunk<CR>",
          ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
          ["n <leader>hS"] = "<cmd>Gitsigns stage_buffer<CR>",
          ["n <leader>hU"] = "<cmd>Gitsigns reset_buffer_index<CR>",

          -- Text objects
          ["o ih"] = ":<C-U>Gitsigns select_hunk<CR>",
          ["x ih"] = ":<C-U>Gitsigns select_hunk<CR>",
        },
        current_line_blame = true, -- default false
        -- Default line options:
        -- current_line_blame_opts = {
        --   virt_text = true,
        --   virt_text_pos = 'eol',
        --   virt_text_priority = 100,
        --   delay = 1000
        -- },
      })
    end,
  },
}
