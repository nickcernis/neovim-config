-- Functions for the Kitty terminal.
-- https://sw.kovidgoyal.net/kitty/
--
-- Bindings are set in local.lua.
--
-- All kitty functions assume this in kitty.conf:
-- allow_remote_control yes
-- listen_on unix:/tmp/mykitty

local M = {}

local function kitty_ls()
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
local function kitty_tab_id_with_name(name)
  local windows = kitty_ls()
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
function M.new_tab()
  local cwd = vim.fn.getcwd()
  local command = string.format(
    "!kitty @ launch --type=tab --tab-title 'shell' --cwd='%s'",
    cwd
  )
  vim.cmd(command)
end

-- Re-run last kitty command and focus the tab.
function M.rerun_last_command()
  local tab_id = kitty_tab_id_with_name("shell")
  vim.cmd(
    string.format(
      "!kitty @ send-text --match-tab 'id:%s' '\\!\\!\\x0d'",
      tab_id
    )
  )
  vim.cmd(string.format("!kitty @ focus-tab --match 'id:%s'", tab_id))
end

-- Switch to Lazygit tab or create it if it does not yet exist.
function M.open_or_switch_to_lazygit()
  local tab_id = kitty_tab_id_with_name("lazygit")

  -- If the tab doesn't exist, create a new one.
  if tab_id == -1 then
    local cwd = vim.fn.getcwd()
    local command = string.format(
      "!kitty @ launch --type=tab --tab-title 'lazygit' --cwd='%s'",
      cwd
    )
    vim.cmd(command)
    -- Schedule the second command to open lazygit after the first command.
    vim.schedule(function()
      vim.cmd(
        "silent !kitty @ send-text --match-tab 'title:^lazygit' 'lazygit\\x0d'"
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

return M
