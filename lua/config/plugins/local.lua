-- Local plugins from ~/.config/nvim/local-plugins/.

return {
  -- GitHub CLI UI picker.
  -- See local-plugins/fzf-github/lua/fzf-github.lua.
  {
    dir = "~/.config/nvim/local-plugins/fzf-github",
    dependencies = { "ibhagwan/fzf-lua" },
    config = function()
      vim.keymap.set(
        "n",
        "<leader>gh",
        '<cmd>lua require("fzf-github").githubcli()<CR>',
        { silent = true, noremap = true, desc = "GitHub CLI" }
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
