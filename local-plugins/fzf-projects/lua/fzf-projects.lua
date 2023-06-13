-- Project switcher using fzf.lua
-- Bound to <c-l> in local.lua.
-- Heavily adapted from https://github.com/ibhagwan/fzf-lua/issues/461#issuecomment-1166900681.
-- Expects fd to be installed.

local fzf_status_ok, fzf_lua = pcall(require, "fzf-lua")
if not fzf_status_ok then
  return
end

local M = {}
local _config = {
  prompt = "Projects> ",
  max_depth = 5,
  excludes = { "node_modules", ".Trash", ".cargo" },
  cwd = "~",
}

function M.setup(config)
  for key, value in pairs(config) do
    _config[key] = value
  end
end

M.projects = function()
  -- Close current buffers, change directory, and present a filepicker when
  -- switching project.
  _config.actions = {
    ["default"] = function(selected)
      -- Close existing buffers.
      vim.cmd("bufdo bwipeout")

      -- Switch to the new project root.
      local git_parent_dir = string.match(selected[1], ".*(~.*)$")
      vim.cmd("cd " .. git_parent_dir)

      -- Change the kitty window title. Helpful if multiple projects are open.
      local cwd = vim.fn.getcwd()
      local home_path = os.getenv("HOME") or ""
      local short_path = string.gsub(cwd, home_path, "~")
      local window_title_command =
        string.format("!kitty @ set-window-title 'nvim %s'", short_path)
      vim.cmd(window_title_command)

      -- Present the file picker.
      vim.api.nvim_command("FzfLua files")
    end,
  }

  -- Present results as the git directory followed by the path.
  _config.fn_transform = function(project_path)
    local home_path = os.getenv("HOME") or ""
    local short_path = string.gsub(project_path, home_path, "~")
    short_path = string.gsub(short_path, "/.git", "")
    short_path = string.gsub(short_path, "%d+%s*~", "~")
    local _, _, git_dir_name = string.find(project_path, "/([^/]+)/%.git")

    return git_dir_name
      .. " "
      .. require("fzf-lua").utils.ansi_codes.magenta(short_path)
  end

  -- Use fd to find .git directories.
  -- See https://github.com/ibhagwan/fzf-lua/wiki/Advanced#pipe-and-transform-a-shell-command.
  local exclude_string = ""
  for _, exclude in pairs(_config.excludes) do
    exclude_string = exclude_string .. string.format("--exclude %s ", exclude)
  end

  local stat_string = "stat -f %m%t%N"

  local fd_command = string.format(
    "fd --hidden --full-path --absolute-path --fixed-strings --type d --prune --max-depth %1d %2s /.git --exec %3s | sort -nr",
    _config.max_depth,
    exclude_string,
    stat_string
  )

  fzf_lua.fzf_exec(fd_command, _config)
end

return M
