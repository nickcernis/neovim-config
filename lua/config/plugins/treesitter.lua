return {
  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        -- See https://github.com/nvim-treesitter/nvim-treesitter#supported-languages.
        -- `:TSUninstall all` to uninstall all.
        -- `:TSUpdate` to install all from ensure_installed.
        ensure_installed = { "c", "lua", "javascript", "json", "php", "phpdoc", "rust", "toml", "markdown", "typescript",
          "tsx", "go", "toml", "yaml", "vim", "vimdoc", "query", "zig" },
        highlight = { enable = true },
        indent = { enable = true, disable = { "python" } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<c-space>",
            node_incremental = "<c-space>",
            scope_incremental = "<c-s>",
            node_decremental = "<c-backspace>",
          },
        },
      })
    end,
  },
}
