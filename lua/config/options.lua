-- Disable netrw as recommended by nvim-tree.
-- https://github.com/nvim-tree/nvim-tree.lua#setup
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Leader must be set before plugins are loaded in case any use leader key bindings.
vim.g.mapleader = " "

-- Experimental Neovim 0.8 feature to hide command line unless in use.
-- Disabled for now because constant prompts to press Enter whenever
-- output appears on the command line are annoying.
-- vim.o.cmdheight = 0

-- Don't soft wrap long lines.
-- vim.wo.wrap = false
-- This is now set dynamically by the textwrap plugin.

-- Permanently show sign column instead of only when signs are active.
-- Stops redraw/layout shift due to sudden appearance of signs.
vim.wo.signcolumn = "yes"

vim.opt.colorcolumn = { "80" }

-- Single status bar across vertical splits.
vim.o.laststatus = 3

-- What to save in sessions, omits defaults like "blank".
vim.o.sessionoptions = "buffers,curdir,folds,winpos,winsize"

-- Don't highlight search results.
-- Can still move through results, and we don't have to clear search highlighting.
vim.o.hlsearch = false

-- Enable mouse mode.
vim.o.mouse = "a"

-- Preserve horizontal blocks with spaces if lines wrap.
vim.o.breakindent = true

-- Save undo history to a file so the undo stack persists between Vim sessions.
vim.o.undofile = true

-- Enables 24-bit color.
-- Makes gui highlight colours apply instead of cterm ones.
vim.opt.termguicolors = true

-- Show whitespace at all times.
-- I like this to reduce whitespace issues in projects
-- without automated formatting and linting.
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↲")
vim.opt.listchars:append("tab:→ ")
vim.opt.listchars:append("extends:⟩")
vim.opt.listchars:append("precedes:⟨")
vim.opt.listchars:append("nbsp:␣")

-- Alter tab widths.
vim.opt.tabstop = 4 -- default 8
vim.opt.softtabstop = 4 -- default 0
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- General settings
vim.wo.number = true -- line numbers by default
vim.o.updatetime = 250 -- default 4000
vim.opt.shortmess:append("I") -- hide startup message
vim.opt.clipboard:append("unnamed")
vim.o.timeoutlen = 200 -- default 1000, reduced here to show which key earlier

-- Improve the completion experience.
-- menuone: Use the popup menu even if there is only one match.
-- noselect: Don't insert text until the user picks a match.
vim.o.completeopt = "menuone,noselect"

-- Case-insensitive search unless a capital letter is used. /Apple matches
-- Apple but not APPLE or apple. /apple matches all variants.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Open new windows to the right or below (moves cursor to right
-- when horizontal splitting, below when vertical splitting).
vim.opt.splitbelow = true
vim.opt.splitright = true
