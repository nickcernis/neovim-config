return {
  -- Which key for key prompts
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        preset = "helix",
        replace = {
          key = {
            { "<space>", "SPC" },
            { "<cr>", "RET" },
            { "<tab>", "TAB" },
          },
        },
      })
      require("which-key").add({
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "config" },
        { "<leader>d", group = "debug" },
        { "<leader>f", group = "fuzzy" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "hunk" },
        { "<leader>q", group = "quit" },
        { "<leader>t", group = "terminal" },
        { "<leader>w", group = "window" },
        { "<leader>x", group = "problems" },
      })
    end,
  },
}
