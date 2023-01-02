return {
  -- File browsing in a helpful tree.
  --
  -- Toggle tree <ctrl-e> ("explore")
  -- <tab> to peek file, <enter> to open, <ctrl-v> to open in vertical split.
  -- Add file (a)
  -- Delete file (d)
  -- Rename/move:
  --   <ctrl-r> full path, allows moving
  --   (r) full file name
  --   (e) basename only (keep extension)
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    -- tag = 'nightly', -- Optional, updated every week, see https://github.com/nvim-tree/nvim-tree.lua/issues/1193.
    -- Config docs at https://github.com/nvim-tree/nvim-tree.lua/blob/master/doc/nvim-tree-lua.txt.
    config = function()
      require("nvim-tree").setup({
        sort_by = "case_sensitive",
        sync_root_with_cwd = true,
        view = {
          side = "left",
          adaptive_size = false,
          mappings = {
            list = {
              { key = "<c-e>", action = "close" },
              { key = "u", action = "dir_up" },
              { key = "?", action = "toggle_help" },
            },
          },
        },
        renderer = {
          highlight_git = true,
          group_empty = true,
        },
        update_focused_file = {
          enable = true,
        },
      })

      -- Bindings.
      vim.keymap.set(
        "n",
        "<leader>e",
        "<cmd>NvimTreeToggle<cr>",
        { silent = true, noremap = true, desc = "browse files" }
      )
      vim.keymap.set(
        "n",
        "<c-e>",
        "<cmd>NvimTreeToggle<cr>",
        { silent = true, noremap = true, desc = "browse files" }
      )
    end,
  },
}
