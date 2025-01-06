-- Project switcher using fzf.lua
-- Bound to <leader-f-j> ('Find proJect').
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

      if not selected or not selected[1] then
        return
      end

      -- Switch to the new project root.
      local git_parent_dir = string.match(selected[1], ".*(~.*)$")
      vim.cmd("cd " .. git_parent_dir)

      -- Update terminal working directory using OSC 7. So that opening a new
      -- terminal split after changing project uses the same current working
      -- directory as the new project, not the original project. Assumes OSC 7
      -- support and a terminal set to open new tabs in the cwd.
      -- See https://lacamb.re/blog/neovim_osc7.html.
      local expanded_path = vim.fn.expand(git_parent_dir)
      local osc7 = string.format(
        "\027]7;file://%s%s\027\\",
        vim.loop.os_uname().sysname == "Darwin" and "localhost" or "",
        expanded_path
      )
      io.stdout:write(osc7)

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
    "cd %s && fd --hidden --full-path --absolute-path --fixed-strings --type d --prune --max-depth %1d %2s /.git --exec %3s | sort -nr",
    _config.cwd,
    _config.max_depth,
    exclude_string,
    stat_string
  )

  fzf_lua.fzf_exec(fd_command, _config)
end

return M
