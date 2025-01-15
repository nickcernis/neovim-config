return {
  -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      -- Extend default parsers with fsharp.
      local parser_config =
        require("nvim-treesitter.parsers").get_parser_configs()
      parser_config.fsharp = {
        install_info = {
          url = "https://github.com/ionide/tree-sitter-fsharp",
          branch = "main",
          files = { "src/scanner.c", "src/parser.c" },
          location = "fsharp",
        },
        requires_generate_from_grammar = false,
        filetype = "fsharp",
      }

      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        -- See https://github.com/nvim-treesitter/nvim-treesitter#supported-languages.
        -- `:TSInstallInfo` to see installed and available.
        -- `:TSUninstall all` to uninstall all.
        -- `:TSUpdate` to install all from ensure_installed.
        ensure_installed = {
          "c",
          "css",
          "fsharp",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "make",
          "markdown",
          "php",
          "phpdoc",
          "query",
          "rust",
          "scss",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "zig",
        },
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
