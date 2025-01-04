return {
  {
    -- Mini file browser and editor.
    -- leader m to open, q to close, jk to nav up and down, hl in and out,
    -- edit/create files by changing them in the nav buffer, press = to
    -- sync that buffer with the filesystem.
    -- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-files.md
    "echasnovski/mini.files",
    version = false,
    dependencies = { 'echasnovski/mini.icons' },
    config = function()
      require("mini.files").setup({
        options = {
          permanent_delete = false,
        },
      })

      -- Bindings.
      vim.keymap.set(
        "n",
        "<leader>m",
        "<cmd>lua MiniFiles.open()<CR>",
        { silent = true, noremap = true, desc = "mini files" }
      )
    end,
  },
}
