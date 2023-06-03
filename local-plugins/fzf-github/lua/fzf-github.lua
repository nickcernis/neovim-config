-- GitHub CLI UI using fzf.lua
-- Bound to <space>gh in local.lua.
-- Expects GitHub CLI to be installed.

local fzf_status_ok, fzf_lua = pcall(require, "fzf-lua")
if not fzf_status_ok then
  return
end

local M = {}

M.githubcli = function(opts)
  local get_pr_number = function(pr_string)
    return string.match(pr_string, "%d+")
  end

  local function get_current_file_line()
    local current_file = vim.fn.expand("%")
    local current_line = vim.fn.line(".")
    return current_file .. ":" .. current_line
  end

  opts = opts or {}
  opts.prompt = "gh> "
  opts.winopts = { height = 0.33, width = 0.2 }
  opts.actions = {
    ["default"] = function(selected)
      if selected[1] == "repo view" then
        vim.cmd("silent !gh repo view --web")
      elseif selected[1] == "pr view" then
        local view_opts = {
          prompt = "gh pr view> ",
          actions = {
            ["default"] = function(pr_selected)
              local cmd = string.format(
                "silent !gh pr view %s --web",
                get_pr_number(pr_selected[1])
              )
              vim.cmd(cmd)
            end,
          },
        }
        fzf_lua.fzf_exec("gh pr list", view_opts)
      elseif selected[1] == "pr checkout" then
        local checkout_opts = {
          prompt = "gh pr checkout> ",
          actions = {
            ["default"] = function(pr_selected)
              local cmd = string.format(
                "!gh pr checkout %s",
                get_pr_number(pr_selected[1])
              )
              vim.cmd(cmd)
            end,
          },
        }
        fzf_lua.fzf_exec("gh pr list", checkout_opts)
      elseif selected[1] == "browse file" then
        local cmd =
          string.format("silent !gh browse %s", get_current_file_line())
        vim.cmd(cmd)
      end
    end,
  }

  fzf_lua.fzf_exec(
    { "pr checkout", "pr view", "browse file", "repo view" },
    opts
  )
end

return M
