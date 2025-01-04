return {
  -- Interactive find and replace within files or the whole project.
  -- Current: https://github.com/MagicDuck/grug-far.nvim
  -- Previously had tried: https://github.com/windwp/nvim-spectre
  "MagicDuck/grug-far.nvim",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    require("grug-far").setup({
      -- engine = 'ripgrep' is default, but 'astgrep' can be specified
    })
    vim.keymap.set(
      "n",
      "<c-r>",
      "<cmd>GrugFar<CR>",
      { silent = true, noremap = true, desc = 'replace' }
    )
    vim.keymap.set(
      "n",
      "<leader>r",
      "<cmd>GrugFar<CR>",
      { silent = true, noremap = true, desc = 'replace' }
    )
  end,
}
