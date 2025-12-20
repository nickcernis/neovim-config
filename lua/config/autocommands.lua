-- Autocommands
-- Hooks functions to events that Neovim emits, so we can do things
-- automatically when certain actions happen in Neovim.

-- Group commands to clear all together and prevent re-definition if this file
  -- <tab> to peek file, <enter> to open, <ctrl-v> to open in vertical split.
  -- Add file (a)
  -- Delete file (d)
  -- Rename/move:
  --   <ctrl-r> full path, allows moving
  --   (r) full file name
  --   (e) basename only (keep extension)
-- is sourced twice in one Vim session. See :h autocmd-groups.
vim.api.nvim_create_augroup("my_autocommands", { clear = true })

-- Highlight text very briefly when copying it.
-- Seems superfluous but is oddly reassuring to let you know the yank occurred.
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "my_autocommands",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 75 })
  end,
})

-- Remove trailing spaces when writing files.
--
-- Excludes Markdown files, which use significant trailing whitespace
-- for reasons that must have made sense to someone at the time.
--
-- This is intended to combine well with ./plugins/autosave.lua, so that exiting
-- insert mode saves the file, triggering this command to trim stray whitespace.
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "my_autocommands",
  pattern = "*",
  callback = function()
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if filetype == "markdown" then
      return false
    end

    -- Store cursor position so that we can restore it.
    local cursor_pos = vim.api.nvim_win_get_cursor(0)

    -- Delete trailing whitespace.
    vim.cmd([[:keepjumps keeppatterns %s/\s\+$//e]])

    -- Delete extra blank lines at the end of the file.
    -- Vim still appends a single newline before the final
    -- write, but it does not show this line in the editor.
    -- See https://vi.stackexchange.com/a/3304/
    vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])

    -- Restore cursor position, adjusting if it was
    -- inside deleted whitespace at the end of the file.
    local num_rows = vim.api.nvim_buf_line_count(0)
    if cursor_pos[1] > num_rows then
      cursor_pos[1] = num_rows
    end
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
})

-- Even out splits when resizing the terminal window containing Vim.
-- Without this, a vertical 50|50 split becomes uneven when changing
-- the terminal window size.
vim.api.nvim_create_autocmd(
  "VimResized",
  { group = "my_autocommands", pattern = "*", command = "wincmd =" }
)
