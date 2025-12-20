return {
  {
    -- Formatter, alternative to mason-null-ls + none-ls.
    -- https://github.com/stevearc/conform.nvim
    -- https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#lazy-loading-with-lazynvim
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      -- https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        -- TODO: make conditional based on formatting dotfile presence? See 'condition' at https://www.lazyvim.org/plugins/formatting#conformnvim or https://github.com/stevearc/conform.nvim?tab=readme-ov-file#options
        javascript = { "prettierd", "eslint_d", stop_after_first = true },
        lua = { "stylua" },
        markdown = { "deno_fmt" },
        php = { "phpcbf" },
        odin = { "odinfmt" },
        rust = { "rustfmt", lsp_format = "fallback" },
        sh = { "shfmt" },
      },
      -- Customize formatter options.
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
        odinfmt = {
          command = "/Users/nick/Play/odin/ols/odinfmt",
          args = { "-stdin" },
          stdin = true,
        },
      },
    },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
      {
        "<c-;>",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
  },
}
