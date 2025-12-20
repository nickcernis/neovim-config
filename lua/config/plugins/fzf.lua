-- I prefer FzfLua over Telescope for fuzzy finding and picking.
--
-- • FzfLua is faster and ‘probably always will be’ according to the author of Telescope: https://news.ycombinator.com/item?id=27164688
-- • Search during indexing of large directories works.
-- • It requires less config due to good defaults (input at top!).
-- • It has fewer plugin dependencies. Compare this file with ./telescope.lua.
-- • FzfLua git_status offers a very decent staging view.
-- • Subjective: I find FzfLua prettier by default.
-- • Bonus: fzf works the same way on the command line outside of Neovim.
return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup({ "fzf-native" }) -- Use bat for previews. https://github.com/ibhagwan/fzf-lua#profiles

      vim.keymap.set(
        "n",
        "<leader>fb",
        fzf_lua.buffers,
        { desc = "buffers", silent = true, noremap = true }
      )
      vim.keymap.set(
        "n",
        "<leader>ft",
        fzf_lua.buffers,
        { desc = "tabs", silent = true, noremap = true }
      )
      vim.keymap.set(
        "n",
        "<leader>fy",
        fzf_lua.lsp_document_symbols,
        { desc = "symbols", silent = true, noremap = true }
      )
      vim.keymap.set(
        "n",
        "<leader>fp",
        fzf_lua.files,
        { desc = "files", silent = true, noremap = true }
      )
      vim.keymap.set(
        "n",
        "<leader>fg",
        fzf_lua.live_grep,
        { desc = "grep", silent = true, noremap = true }
      )
      vim.keymap.set(
        "n",
        "<leader>ff",
        fzf_lua.blines,
        { desc = "find", silent = true, noremap = true }
      )
      vim.keymap.set(
        "n",
        "<leader>fs",
        fzf_lua.git_status,
        { desc = "git status", silent = true, noremap = true }
      )
    end,
  },
}
