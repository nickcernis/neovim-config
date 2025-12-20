return {
  -- File browsing in a helpful tree.
  -- https://github.com/nvim-neo-tree/neo-tree.nvim
  --
  -- Toggle tree <ctrl-e> ("explore")
  -- a for new files or folders
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
      -- Bindings.
      vim.keymap.set(
        "n",
        "<leader>e",
        "<cmd>Neotree toggle<cr>",
        { silent = true, noremap = true, desc = "browse files" }
      )
    end,
  },
}
