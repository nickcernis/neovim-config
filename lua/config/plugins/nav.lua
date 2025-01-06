return {
  {
    -- Jump to any word start by typing <space-j> followed by a character target.
    -- https://github.com/phaazon/hop.nvim
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup() -- See :h hop-config.
      vim.keymap.set(
        "n",
        "<leader>j",
        "<cmd>HopWordMW<cr>",
        { silent = true, noremap = true, desc = "jump to" }
      )
    end,
  },
}
