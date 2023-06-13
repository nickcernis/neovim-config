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

-- Config handling
set(
  "n",
  "<leader>ce",
  "<cmd>edit ~/.config/nvim/init.lua<cr>",
  { silent = true, noremap = true, desc = "edit config" }
)
set(
  "n",
  "<leader>cs",
  "<cmd>source ~/.config/nvim/init.lua<cr>",
  { silent = true, noremap = true, desc = "source config" }
)
set(
  "n",
  "<leader>cp",
  "<cmd>edit ~/.config/nvim/lua/user/plugins.lua<cr>",
  { silent = true, noremap = true, desc = "edit plugin config" }
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

-- Open new Kitty tab in current working directory.
set(
  "n",
  "<leader>tt",
  ":lua Keymaps.kitty_new_tab()<cr><cr>",
  { silent = true, noremap = true, desc = "new kitty tab" }
)

set(
  "n",
  "<leader>tr",
  ":lua Keymaps.kitty_rerun_last_command()<cr><cr>",
  { silent = true, noremap = true, desc = "rerun last command" }
)

set(
  "n",
  "<leader>tg",
  ":lua Keymaps.kitty_open_or_switch_to_lazygit()<cr><cr>",
  { silent = true, noremap = true, desc = "lazygit" }
)

Keymaps = {}

function Keymaps._kitty_ls()
  -- Execute 'kitty @ ls' to list all tab information.
  local success, output = pcall(vim.fn.system, "kitty @ ls")

  -- Parse the output as JSON.
  local windows = {}
  if success then
    local decoded_output = vim.fn.json_decode(output)
    if type(decoded_output) == "table" then
      windows = decoded_output
    end
  end

  return windows
end

-- Get the ID of the tab with `name` from the focused window.
function Keymaps._kitty_tab_id_with_name(name)
  local windows = Keymaps._kitty_ls()
  for _, window in ipairs(windows) do
    if window.is_focused == true then
      for _, tab in ipairs(window.tabs) do
        if tab.title == name then
          return tab.id
        end
      end
    end
  end

  return -1
end

-- Spawns a new kitty terminal tab in the current Neovim working directory.
-- All kitty functions assume the following in kitty.conf:
-- allow_remote_control yes
-- listen_on unix:/tmp/mykitty
function Keymaps.kitty_new_tab()
  local cwd = vim.fn.getcwd()
  local command = string.format(
    "!kitty @ launch --type=tab --tab-title 'shell' --cwd='%s'",
    cwd
  )
  vim.cmd(command)
end

-- Re-run last kitty command and focus the tab.
function Keymaps.kitty_rerun_last_command()
  local tab_id = Keymaps._kitty_tab_id_with_name("shell")
  print("tab_id is" .. tostring(tab_id))
  vim.cmd(
    string.format(
      [[!kitty @ send-text --match-tab 'id:%s' '\!\!\\x0d']],
      tab_id
    )
  )
  vim.cmd(string.format("!kitty @ focus-tab --match 'id:%s'", tab_id))
end

-- Switch to Lazygit tab or create it if it does not yet exist.
function Keymaps.kitty_open_or_switch_to_lazygit()
  local tab_id = Keymaps._kitty_tab_id_with_name("lazygit")

  -- If the tab doesn't exist, create a new one.
  if tab_id == -1 then
    local cwd = vim.fn.getcwd()
    local command = string.format(
      "!kitty @ launch --type=tab --tab-title 'lazygit' --cwd='%s' lazygit",
      cwd
    )
    vim.cmd(command)
    -- Schedule the second command to open lazygit after the first command.
    vim.schedule(function()
      vim.cmd(
        [[silent !kitty @ send-text --match-tab 'title:^lazygit' 'lazygit\\x0d']]
      )

      -- Dismiss the "Press ENTER or type command to continue" prompt if needed.
      -- vim.api.nvim_input("\n")
      -- Alternative way to dismiss the prompt:
      -- vim.api.nvim_feedkeys(
      --   vim.api.nvim_replace_termcodes("<CR>", true, false, true),
      --   "n",
      --   true
      -- )
    end)
  else
    -- Switch to the existing tab
    local command = string.format("!kitty @ focus-tab --match 'id:%s'", tab_id)
    vim.cmd(command)
  end
end
