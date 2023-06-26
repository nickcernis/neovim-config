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
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "stage hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "reset hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
          map(
            "n",
            "<leader>hu",
            gs.undo_stage_hunk,
            { desc = "undo stage hunk" }
          )
          map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "blame line" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
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
