--
-- General keymaps.
-- Plugin-specific keymaps live with plugin configs.
-- That way removing a plugin removes its keymaps.
--
local set = vim.keymap.set

-- Send dd, d, D, and ci to blackhole register instead of system clipboard.
-- Prevents filling the clipboard with deleted lines prior to pasting.
set({ "n", "v" }, "d", '"_d', { noremap = true })
set({ "n", "v" }, "D", '"_D', { noremap = true })
set({ "n", "v" }, "c", '"_c', { noremap = true })
set({ "n", "v" }, "C", '"_C', { noremap = true })

-- Window manipulation
set(
  "n",
  "<leader>wv",
  "<cmd>vsplit<cr>",
  { silent = true, noremap = true, desc = "vsplit" }
)
set(
  "n",
  "<leader>ws",
  "<cmd>split<cr>",
  { silent = true, noremap = true, desc = "split" }
)
set(
  "n",
  "<leader>wr",
  "<cmd>wincmd r<cr>",
  { silent = true, noremap = true, desc = "rotate" }
)
set(
  "n",
  "<leader>wx",
  "<cmd>q<cr>",
  { silent = true, noremap = true, desc = "quit" }
)
set(
  "n",
  "<leader>wd",
  "<cmd>q<cr>",
  { silent = true, noremap = true, desc = "quit" }
)
set(
  "n",
  "<leader>wl",
  "<cmd>wincmd l<cr>",
  { silent = true, noremap = true, desc = "cursor right" }
)
set(
  "n",
  "<leader>wh",
  "<cmd>wincmd h<cr>",
  { silent = true, noremap = true, desc = "cursor left" }
)
set(
  "n",
  "<leader>wj",
  "<cmd>wincmd j<cr>",
  { silent = true, noremap = true, desc = "cursor down" }
)
set(
  "n",
  "<leader>wk",
  "<cmd>wincmd k<cr>",
  { silent = true, noremap = true, desc = "cursor up" }
)

-- Buffer commands
set(
  "n",
  "<leader>bd",
  ":bd<cr>",
  { silent = true, noremap = true, desc = "close buffer" }
)
set(
  "n",
  "<leader>bx",
  ":bd<cr>",
  { silent = true, noremap = true, desc = "close buffer" }
)

-- Nudge text up and down a line in visual mode with J and K.
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Restore gx functionality due to disabled netrw.
-- https://www.reddit.com/r/neovim/comments/ro6oye/open_link_from_neovim/.
set(
  "n",
  "gx",
  "<cmd>execute '!open ' . shellescape(expand('<cfile>'), 1)<cr><cr>",
  { silent = true, noremap = true }
)

-- 'go' to go back ([g]o to [o]riginal).
-- More natural partner to gd (go to definition) than Ctrl-o.
set(
  "n",
  "go",
  "<C-o>",
  { noremap = false, desc = "back" }
)

-- Quit but save all changed buffers.
set(
  "n",
  "<leader>qq",
  "<cmd>wqall<cr>",
  { silent = true, noremap = true, desc = "quit all" }
)
set(
  "n",
  "<c-q>",
  "<cmd>wqall<cr>",
  { silent = true, noremap = true, desc = "quit all" }
)
