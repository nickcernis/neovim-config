return {
  -- File manipulation (creation, deletion, rename, move) by editing a regular buffer.
  -- https://github.com/stevearc/oil.nvim
  {
    "stevearc/oil.nvim",
    opts = {},
    config = function()
      require("oil").setup({
        delete_to_trash = true,
        keymaps = {
          ["q"] = { "actions.close", mode = "n" },
        },
      })

      -- Bindings.
      vim.keymap.set(
        "n",
        "<leader>o",
        "<cmd>Oil --float .<cr>",
        { silent = true, noremap = true, desc = "oil files" }
      )
    end,
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  },
}
