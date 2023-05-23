--  ___________________________
--  Here be LSP configuration >
--  ---------------------------
--       \                   / \  //\
--        \    |\___/|      /   \//  \\
--             /0  0  \__  /    //  | \ \
--            /     /  \/_/    //   |  \  \
--            @_^_@'/   \/_   //    |   \   \
--            //_^_/     \/_ //     |    \    \
--         ( //) |        \///      |     \     \
--       ( / /) _|_ /   )  //       |      \     _\
--     ( // /) '/,_ _ _/  ( ; -.    |    _ _\.-~        .-~~~^-.
--   (( / / )) ,-{        _      `-.|.-~-.           .~         `.
--  (( // / ))  '/\      /                 ~-. _ .-~      .-~^-.  \
--  (( /// ))      `.   {            }                   /      \  \
--   (( / ))     .----~-.\        \-'                 .~         \  `. \^-.
--              ///.----..>        \             _ -~             `.  ^-`  ^-_
--                ///-._ _ _ _ _ _ _}^ - - - - ~                     ~-- ,.-~
--                                                                   /.-~

-- This file configures LSP plugins manually and explains why they're needed.
--
-- Alternatives to manual configuration:
--
-- 1. LSP Zero: https://github.com/VonHeikemen/lsp-zero.nvim
--
-- 2. Preconfigured Neovim distros like https://www.lunarvim.org/ or
--    https://nvchad.com/ or https://astronvim.github.io/.
--
-- 3. Cherry pick from the semi-official starter config, or copy it outright
--    if you’re starting with an empty init.lua:
--
--    https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
--
-- 4. Use CoC if you can live with the name and the Node.js dependency and
--    having to install, configure and update language servers using shell
--    commands and a JSON config.
--
--    https://github.com/neoclide/coc.nvim#example-lua-configuration.
--
-- 5. Live without LSP. Denounce soap and Wi-Fi. Move to Sealand.
--
-- 6. Switch to an editor that offers good LSP integration with less effort
--    like VS Code or Fleet or Helix, or an IDE with LSP-like features,
--    like everything JetBrains makes.
--
-- ## Understanding Neovim's LSP support
--
-- Neovim's built-in LSP support is basic. :h lsp describes it as a “framework
-- for building enhanced LSP tools”. This means we need to provide:
--
-- 1. Language servers.
--
-- 2. Configuration to tell Neovim which servers can be started and “attached”
--    for which filetypes.
--
-- 3. Glue code to tell Neovim that we have servers installed for specific
--    filetypes so it will actually attach the client to those servers.
--
-- 4. Keybindings for LSP actions such as “format” and “go to definition”.
--
-- 5. Completion UI if you use it.
--
-- 6. Snippets if you want them.
--
-- 7. Formatters/linters for languages without formatting/linting support in
--    their language server.
--
-- 8. DAP – Debug Adapter Provider support if you don't just println!() your
--    way to success.
--
-- For me, Neovim's speed and hackability outweigh extremely sucky LSP
-- configuration. With that, let's look at the LSP config code!

-- local lsp_servers_to_auto_install = {}

-- Return a list of plugins for the Lazy plugin manager to install.
-- See lua/config/lazy.nvim for my bootstrap code.
return {
  {
    -- Configures known LSP servers to work with Neovim's LSP client.
    -- So that features such as attaching, completion, go-to-definition,
    -- formatting, hover and rename are configured for each language server.
    -- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",

    dependencies = {
      -- Configures the lua-language-server for our Neovim config and
      -- plugins. Gives information for vim.* and Neovim API functions.
      -- Prevents 'undefined global vim' LSP messages in our config.
      -- https://github.com/folke/neodev.nvim
      "folke/neodev.nvim",

      -- Mason installs LSP servers, DAP servers, linters, formatters.
      -- https://github.com/williamboman/mason.nvim
      "williamboman/mason.nvim",

      -- Hooks Mason to lspconfig so the LSP client auto attaches.
      -- for filetypes with installed language servers.
      -- https://github.com/williamboman/mason-lspconfig.nvim
      "williamboman/mason-lspconfig.nvim",

      -- Completion engine for as-you-type suggestions.
      -- https://github.com/hrsh7th/nvim-cmp
      "hrsh7th/nvim-cmp",

      -- Completion sources. These provide suggestions in the completion
      -- list. Find others here:
      -- https://github.com/topics/nvim-cmp
      "hrsh7th/cmp-nvim-lsp", -- Use LSP server for completions.
      -- "hrsh7th/cmp-buffer", -- Use strings from current buffer.
      "hrsh7th/cmp-path", -- Complete file paths for current project.
      "hrsh7th/cmp-nvim-lua", -- Complete Neovim's Lua API.

      -- Snippets
      "L3MON4D3/LuaSnip", -- Snippet plugin.
      "saadparwaiz1/cmp_luasnip", -- See snippets in completion list.
      "rafamadriz/friendly-snippets", -- Large snippet library.

      -- Fidget adds LSP status and logging above the status line for
      -- long-running LSP tasks. Useful to keep an eye on LSP processes
      -- and :LspRestart if needed, without taking up status line space.
      "j-hui/fidget.nvim",

      -- Integrate linters and formatters that don't use an LSP server.
      "jose-elias-alvarez/null-ls.nvim",
      "jayp0521/mason-null-ls.nvim",
      "nvim-lua/plenary.nvim", -- needed for null-ls

      -- Consider LSP saga?
      -- https://github.com/glepnir/lspsaga.nvim
    },

    -- Call setup functions for the above plugins to orchestrate the whole
    -- mess into something approximating a coherent LSP featureset.
    config = function()
      -- Adjust Lua language server settings for this Neovim workspace.
      require("neodev").setup()

      -- Configure keybindings only when a language server “attaches”
      -- to the buffer, and only if that language server supports the
      -- features we need for that binding.
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          -- K to show hover hints
          if client.server_capabilities.hoverProvider then
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = args.buf })
          end

          local lsp_format = function(bufnr)
            vim.lsp.buf.format({
              filter = function(client_)
                -- Prevent certain LSP servers from formatting.
                -- Useful if we want to defer to an external tool via null-ls.
                -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts#neovim-08
                if
                  client_.name == "tsserver"
                  or client_.name == "lua-language-server"
                then
                  return false
                else
                  return true
                end
              end,
              bufnr = bufnr,
            })
          end

          -- <Ctrl-;> to format.
          if client.server_capabilities.documentFormattingProvider then
            vim.keymap.set(
              { "n", "v" },
              "<c-;>",
              lsp_format, -- vim.lsp.buf.format,
              { buffer = args.buf }
            )
          end

          vim.keymap.set(
            "n",
            "gd",
            vim.lsp.buf.definition,
            { buffer = args.buf }
          )
          vim.keymap.set(
            "n",
            "gD",
            vim.lsp.buf.declaration,
            { buffer = args.buf }
          )
          vim.keymap.set(
            "n",
            "gi",
            vim.lsp.buf.implementation,
            { buffer = args.buf }
          )
          vim.keymap.set(
            "n",
            "go",
            vim.lsp.buf.type_definition,
            { buffer = args.buf }
          )
          vim.keymap.set(
            "n",
            "gr",
            vim.lsp.buf.references,
            { buffer = args.buf }
          )
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { buffer = args.buf })
          vim.keymap.set(
            "n",
            "<F4>",
            vim.lsp.buf.code_action,
            { buffer = args.buf }
          )
          vim.keymap.set(
            "x",
            "<F4>",
            vim.lsp.buf.code_action,
            { buffer = args.buf }
          )
        end,
      })

      -- Color line numbers for LSP diagnostics instead of displaying
      -- gutter symbols. If we don't do this, LSP warnings and info will
      -- leave a symbol in the gutter on the relevant line, taking the
      -- place of git gutter marks for that line.
      --
      -- By using coloured line numbers for diagnostics, we can _also_
      -- have git gutter marks, which means we don't lose information
      -- about git status when there's an LSP warning on that line.
      vim.cmd([[highlight DiagnosticDefaultError guifg=#e85751 gui=nocombine]])
      vim.cmd([[highlight DiagnosticDefaultWarn guifg=#d7aa49 gui=nocombine]])
      vim.cmd([[highlight DiagnosticDefaultInfo guifg=#b9ba46 gui=nocombine]])
      vim.cmd([[highlight DiagnosticDefaultHint guifg=#7c938a gui=nocombine]])
      vim.fn.sign_define(
        "DiagnosticSignError",
        { text = "", numhl = "DiagnosticDefaultError" }
      )
      vim.fn.sign_define(
        "DiagnosticSignWarn",
        { text = "", numhl = "DiagnosticDefaultWarn" }
      )
      vim.fn.sign_define(
        "DiagnosticSignInfo",
        { text = "", numhl = "DiagnosticDefaultInfo" }
      )
      vim.fn.sign_define(
        "DiagnosticSignHint",
        { text = "", numhl = "DiagnosticDefaultHint" }
      )

      -- Activate mason and mason-lspconfig.
      require("mason").setup()

      require("mason-lspconfig").setup({
        -- Install servers by default.
        -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "tsserver",
        },
        automatic_installation = true,
      })

      -- TODO: handle optional overrides for each language server.
      -- local servers = {
      --   -- gopls = {},
      --   -- rust_analyzer = {},
      --   -- tsserver = {},
      --
      --   sumneko_lua = {
      --     Lua = {
      --       workspace = { checkThirdParty = false },
      --       telemetry = { enable = false },
      --     },
      --   },
      -- }

      -- Set up completion.
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        -- TODO: compare with mappings here: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua#LL394C4-L394C4
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
          { name = "path" },
          -- { name = 'buffer' },
        },
      })

      -- Set up completion capabilities for lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Set up installed servers by default, without having to specify
      -- each one manually.
      require("mason-lspconfig").setup_handlers({
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't
        -- have a dedicated handler.
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
          })
        end,
        -- Optionally provide a dedicated handler for specific servers.
        -- For example, a handler override for the `rust_analyzer`:
        -- ["rust_analyzer"] = function ()
        --     require("rust-tools").setup {}
        -- end
      })

      local null_ls = require("null-ls")

      require("mason-null-ls").setup({
        -- Available tools: https://github.com/jay-babu/mason-null-ls.nvim#available-null-ls-sources
        -- TODO: configure eslint_d and prettierd if needed.
        ensure_installed = { "stylua", "eslint_d", "prettierd" },
      })

      require("mason-null-ls").setup({
        automatic_setup = true,
      })

      -- Set up installed and configured sources above.
      null_ls.setup()

      -- Show LSP status above the status line.
      require("fidget").setup()
    end,
  },

  -- TODO: DAP for Rust.
}
