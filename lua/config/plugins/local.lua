-- Local plugins from ~/.config/nvim/local-plugins/.

return {
  -- Kitty terminal commands.
  -- See local-plugins/kitty/lua/kitty.lua.
  {
    dir = "~/.config/nvim/local-plugins/kitty",
    config = function()
      -- Open new Kitty tab in current working directory.
      vim.keymap.set(
        "n",
        "<leader>tt",
        ':lua require("kitty").new_tab()<cr><cr>',
        { silent = true, noremap = true, desc = "new kitty tab" }
      )

      -- Re-run last Kitty command from the shell tab.
      vim.keymap.set(
        "n",
        "<leader>tr",
        ':lua require("kitty").rerun_last_command()<cr><cr>',
        { silent = true, noremap = true, desc = "rerun last command" }
      )

      -- Open or switch to a tab displaying lazygit.
      vim.keymap.set(
        "n",
        "<leader>tg",
        ':lua require("kitty").open_or_switch_to_lazygit()<cr><cr>',
        { silent = true, noremap = true, desc = "lazygit" }
      )
    end,
  },

  -- GitHub CLI UI picker.
  -- See local-plugins/fzf-github/lua/fzf-github.lua.
  {
    dir = "~/.config/nvim/local-plugins/fzf-github",
    dependencies = { "ibhagwan/fzf-lua" },
    config = function()
      vim.keymap.set(
        "n",
        "<leader>gh",
        '<cmd>lua require("fzf-github").githubcli()<CR>'
      )
    end,
  },

  -- Project picker.
  -- See local-plugins/fzf-projects/lua/fzf-projects.lua
  {
    dir = "~/.config/nvim/local-plugins/fzf-projects",
    dependencies = { "ibhagwan/fzf-lua" },
    config = function()
      require("fzf-projects").setup({
        excludes = {
          "node_modules",
          "/Dropbox",
          ".emacs.d",
          "kitty-themes",
          ".Trash",
          "/Library",
          ".github",
          ".gitkraken",
          ".gitlibs",
          ".wp-env",
          ".doom.d",
          ".cargo",
        },
      })

      vim.keymap.set(
        "n",
        "<leader>fj",
        '<cmd>lua require("fzf-projects").projects()<CR>',
        { silent = true, noremap = true, desc = "projects" }
      )
    end,
  },
}
