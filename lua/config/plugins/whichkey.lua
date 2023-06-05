return {
  -- Which key for key prompts
  -- https://github.com/folke/which-key.nvim
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        key_labels = {
          ["<space>"] = "SPC",
          ["<cr>"] = "RET",
          ["<tab>"] = "TAB",
        },
        layout = {
          align = "center",
        },
      })
      require("which-key").register({
        ["<leader>w"] = {
          name = "window",
        },
        ["<leader>d"] = {
          name = "debug",
        },
        ["<leader>t"] = {
          name = "tab",
        },
        ["<leader>q"] = {
          name = "quit",
        },
        ["<leader>g"] = {
          name = "git",
        },
        ["<leader>f"] = {
          name = "file",
        },
        ["<leader>c"] = {
          name = "config",
        },
        ["<leader>b"] = {
          name = "buffer",
        },
        ["<leader>h"] = {
          name = "hunk",
        },
        ["<leader>x"] = {
          name = "problems",
        },
      })
    end,
  },
}
