-- Project switcher using fzf.lua
-- Bound to <c-l> in keymaps.lua.
-- Heavily adapted from https://github.com/ibhagwan/fzf-lua/issues/461#issuecomment-1166900681.
-- Expects fd to be installed.

local fzf_status_ok, fzf_lua = pcall(require, "fzf-lua")
if not fzf_status_ok then
    return
end

local M = {}

M.projects = function(opts)
    opts = opts or {}
    opts.prompt = "Projects> "
    opts.cwd = "~"
    opts.actions = {
        ['default'] = function(selected)
            vim.cmd("bufdo bwipeout")
            local git_parent_dir = string.match(selected[1], ".*(~.*)$")
            vim.cmd("cd " .. git_parent_dir)
            vim.api.nvim_command("FzfLua files")
        end
    }

    -- Present results as the git directory followed by the path.
    -- Uses fd to find .git directories.
    -- See https://github.com/ibhagwan/fzf-lua/wiki/Advanced#pipe-and-transform-a-shell-command.
    opts.fn_transform = function(project_path)
        local home_path = os.getenv("HOME") or ""
        local short_path = string.gsub(project_path, home_path, "~")
        short_path = string.gsub(short_path, "/.git", "")
        local _, _, git_dir_name = string.find(project_path, "/([^/]+)/%.git")

        return  git_dir_name .. " " .. require 'fzf-lua'.utils.ansi_codes.magenta(short_path)
    end

    fzf_lua.fzf_exec(
        'fd --hidden --full-path --absolute-path --fixed-strings --type d --prune --max-depth 5 --exclude /Dropbox --exclude .emacs.d --exclude kitty-themes --exclude .Trash --exclude node_modules --exclude Library --exclude ".github" --exclude ".gitkraken" --exclude ".gitlibs" --exclude ".wp-env" --exclude ".doom.d" --exclude ".cargo" /.git | sort',
        opts
    )
end

return M
