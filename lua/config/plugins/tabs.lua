-- Tabs! With gentle animations! Like a real editor for real people!
-- But without using the mouse (unless you want to).
--
-- It's pretty great. I like this more than VS Code's tabs. Thanks, Rom Grk.
--
-- https://github.com/romgrk/barbar.nvim
return {
  "romgrk/barbar.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Jump to tab by letter, amazing when your tab list looks like your product manager's browser window.
    vim.keymap.set(
      "n",
      "<leader>t",
      "<cmd>BufferPick<cr>",
      { silent = true, noremap = true }
    )

    -- Close buffer without affecting layout. Overwrites the default wincmd shortcut, but that's ok.
    vim.keymap.set(
      "n",
      "<c-w>",
      "<cmd>BufferClose<cr>",
      { silent = true, noremap = true }
    )

    -- Move between tabs.
    vim.keymap.set(
      "n",
      "<c-j>",
      "<cmd>BufferNext<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-k>",
      "<cmd>BufferPrevious<cr>",
      { silent = true, noremap = true }
    )

    vim.keymap.set(
      "n",
      "<c-1>",
      "<cmd>BufferGoto1<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-2>",
      "<cmd>BufferGoto2<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-3>",
      "<cmd>BufferGoto3<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-4>",
      "<cmd>BufferGoto4<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-5>",
      "<cmd>BufferGoto5<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-6>",
      "<cmd>BufferGoto6<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-7>",
      "<cmd>BufferGoto7<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-8>",
      "<cmd>BufferGoto8<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-9>",
      "<cmd>BufferGoto9<cr>",
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<c-0>",
      "<cmd>BufferLast<cr>",
      { silent = true, noremap = true }
    )
  end,
}
