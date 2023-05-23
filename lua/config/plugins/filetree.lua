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

      -- Generated with NvimTreeGenerateAttach.
      -- This function has been generated from your
      --   view.mappings.list
      --   view.mappings.custom_only
      --   remove_keymaps
      --
      -- You should add this function to your configuration and set on_attach = on_attach in the nvim-tree setup call.
      --
      -- Although care was taken to ensure correctness and completeness, your review is required.
      --
      -- Please check for the following issues in auto generated content:
      --   "Mappings removed" is as you expect
      --   "Mappings migrated" are correct
      --
      -- Please see https://github.com/nvim-tree/nvim-tree.lua/wiki/Migrating-To-on_attach for assistance in migrating.
      --
      local function on_attach(bufnr)
        local api = require('nvim-tree.api')

        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Mappings migrated from view.mappings.list
        --
        -- You will need to insert "your code goes here" for any mappings with a custom action_cb
        vim.keymap.set('n', '<c-e>', api.tree.close, opts('Close'))
        vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
        vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))

      end

      require("nvim-tree").setup({
        on_attach = on_attach,
        sort_by = "case_sensitive",
        sync_root_with_cwd = true,
        view = {
          side = "left",
          adaptive_size = false,
          -- Old custom list mappings, now migrated to on_attach.
          -- mappings = {
          --   list = {
          --     { key = "<c-e>", action = "close" },
          --     { key = "u", action = "dir_up" },
          --     { key = "?", action = "toggle_help" },
          --   },
          -- },
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
