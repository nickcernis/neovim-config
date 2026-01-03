--  __________________________________
-- < OOoo, it's Nick's Neovim config. >
--  ----------------------------------
--  \     /\  ___  /\
--   \   // \/   \/ \\
--      ((    O O    ))
--       \\ /     \ //
--        \/  | |  \/
--         |  | |  |
--         |  | |  |
--         |   o   |
--         | |   | |
--         |m|   |m|

-- ============================================================================
-- SECTION 1: VIM OPTIONS
-- ============================================================================

-- Disable netrw as recommended by neo-tree.
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Leader must be set before plugins are loaded.
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Hide command line unless in use.
vim.o.cmdheight = 0

-- Permanently show sign column to prevent layout shift.
vim.wo.signcolumn = "yes"

vim.opt.colorcolumn = { "80" }

-- Single status bar across vertical splits.
vim.o.laststatus = 3

-- What to save in sessions.
vim.o.sessionoptions = "buffers,curdir,folds,winpos,winsize"

-- Don't highlight search results.
vim.o.hlsearch = false

-- Enable mouse mode.
vim.o.mouse = "a"

-- Preserve horizontal blocks with spaces if lines wrap.
vim.o.breakindent = true

-- Save undo history to a file.
vim.o.undofile = true

-- Enable 24-bit color.
vim.opt.termguicolors = true

-- Replace ~ with space on empty lines.
vim.opt.fillchars:append({ eob = " " })

-- Tab widths (may be overridden by guess-indent).
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- General settings.
vim.wo.number = true
vim.o.updatetime = 250
vim.opt.shortmess:append("I")
vim.opt.clipboard:append("unnamedplus")
vim.o.timeoutlen = 200

-- Improve completion experience.
vim.o.completeopt = "menuone,noselect"

-- Case-insensitive search unless a capital letter is used.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Open new windows to the right or below.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Hide the winbar.
vim.opt.winbar = nil

-- ============================================================================
-- SECTION 2: LAZY.NVIM BOOTSTRAP
-- ============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- ============================================================================
-- SECTION 3: PLUGIN SPECIFICATIONS
-- ============================================================================

require("lazy").setup({
  -- Color scheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
        on_colors = function(colors)
          colors.comment = "#747fb3" -- Better contrast than default.
        end,
      })
      vim.cmd("colorscheme tokyonight-night")
    end,
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        scope = { enabled = true },
      })
    end,
  },

  -- Status line
  {
    "echasnovski/mini.statusline",
    config = function()
      require("mini.statusline").setup()
    end,
  },

  -- File tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    config = function()
      vim.keymap.set(
        "n",
        "<leader>e",
        "<cmd>Neotree toggle<cr>",
        { silent = true, noremap = true, desc = "browse files" }
      )
    end,
  },

  -- Fuzzy finder
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf_lua = require("fzf-lua")
      fzf_lua.setup({ "fzf-native" })

      vim.keymap.set(
        "n",
        "<leader>fb",
        fzf_lua.buffers,
        { desc = "buffers", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>ft",
        fzf_lua.buffers,
        { desc = "tabs", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>fy",
        fzf_lua.lsp_document_symbols,
        { desc = "symbols", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>fp",
        fzf_lua.files,
        { desc = "files", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>fg",
        fzf_lua.live_grep,
        { desc = "grep", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>ff",
        fzf_lua.blines,
        { desc = "find", silent = true }
      )
      vim.keymap.set(
        "n",
        "<leader>fs",
        fzf_lua.git_status,
        { desc = "git status", silent = true }
      )
    end,
  },

  -- Find and replace
  {
    "MagicDuck/grug-far.nvim",
    config = function()
      require("grug-far").setup({})
      vim.keymap.set(
        "n",
        "<leader>r",
        "<cmd>GrugFar<CR>",
        { silent = true, desc = "replace" }
      )
    end,
  },

  -- Word jumping
  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup()
      vim.keymap.set(
        "n",
        "<leader>j",
        "<cmd>HopWordMW<cr>",
        { silent = true, desc = "jump to" }
      )
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- Comments (gcc to comment line)
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c",
          "css",
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

  -- Text wrapping, auto soft-wraps Markdown.
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup({
        softener = { markdown = true },
      })
    end,
  },

  -- Guess indent
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          map("n", "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
          map("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "stage hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "reset hunk" })
          map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
          map(
            "n",
            "<leader>hu",
            gs.undo_stage_hunk,
            { desc = "undo stage hunk" }
          )
          map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
          map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
          map("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { desc = "blame line" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
        end,
        current_line_blame = true,
      })
    end,
  },

  -- LSP and completion
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
    },
    config = function()
      -- Only keep servers for C, Go, TypeScript
      local servers = {
        "clangd",
        "gopls",
        "ts_ls",
      }

      -- Completion setup
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
        },
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Register server configs
      for _, server in ipairs(servers) do
        vim.lsp.config(server, {
          capabilities = capabilities,
        })
      end

      -- LSP keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "x" }, "<F4>", vim.lsp.buf.code_action, opts)
        end,
      })

      vim.diagnostic.config({
        virtual_text = false,
        severity_sort = true,
        float = { border = "rounded", source = "always" },
      })

      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = servers,
        automatic_enable = true,
      })
    end,
  },

  -- Code formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        javascript = { "prettierd", "eslint_d", stop_after_first = true },
        typescript = { "prettierd", "eslint_d", stop_after_first = true },
        lua = { "stylua" },
        markdown = { "deno_fmt" },
        php = { "phpcbf" },
        rust = { "rustfmt", lsp_format = "fallback" },
        sh = { "shfmt" },
        go = { "gofmt" },
      },
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },
        },
      },
    },
    keys = {
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

  -- Which-key
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup({
        preset = "helix",
        replace = {
          key = {
            { "<space>", "SPC" },
            { "<cr>", "RET" },
            { "<tab>", "TAB" },
          },
        },
      })
      require("which-key").add({
        { "<leader>b", group = "buffer" },
        { "<leader>f", group = "fuzzy" },
        { "<leader>g", group = "git" },
        { "<leader>h", group = "hunk" },
        { "<leader>q", group = "quit" },
        { "<leader>w", group = "window" },
      })
    end,
  },

  -- Auto-save
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        trigger_events = { "InsertLeave" },
        execution_message = {
          message = function()
            return ("💾 " .. vim.fn.strftime("%H:%M:%S"))
          end,
        },
      })
    end,
  },
}, {
  change_detection = {
    notify = false,
  },
})

-- ============================================================================
-- SECTION 4: KEYMAPS
-- ============================================================================

local set = vim.keymap.set

-- Send d, D, c, C to blackhole register instead of clipboard.
set({ "n", "v" }, "d", '"_d', { noremap = true })
set({ "n", "v" }, "D", '"_D', { noremap = true })
set({ "n", "v" }, "c", '"_c', { noremap = true })
set({ "n", "v" }, "C", '"_C', { noremap = true })

-- Window manipulation
set("n", "<leader>wv", "<cmd>vsplit<cr>", { silent = true, desc = "vsplit" })
set("n", "<leader>ws", "<cmd>split<cr>", { silent = true, desc = "split" })
set("n", "<leader>wr", "<cmd>wincmd r<cr>", { silent = true, desc = "rotate" })
set("n", "<leader>wx", "<cmd>q<cr>", { silent = true, desc = "quit" })
set("n", "<leader>wd", "<cmd>q<cr>", { silent = true, desc = "quit" })
set(
  "n",
  "<leader>wl",
  "<cmd>wincmd l<cr>",
  { silent = true, desc = "cursor right" }
)
set(
  "n",
  "<leader>wh",
  "<cmd>wincmd h<cr>",
  { silent = true, desc = "cursor left" }
)
set(
  "n",
  "<leader>wj",
  "<cmd>wincmd j<cr>",
  { silent = true, desc = "cursor down" }
)
set(
  "n",
  "<leader>wk",
  "<cmd>wincmd k<cr>",
  { silent = true, desc = "cursor up" }
)

-- Buffer commands
set("n", "<leader>bd", ":bd<cr>", { silent = true, desc = "close buffer" })
set("n", "<leader>bx", ":bd<cr>", { silent = true, desc = "close buffer" })

-- Move text up and down in visual mode
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

-- Restore gx functionality (required because netrw is disabled)
set(
  "n",
  "gx",
  "<cmd>execute '!open ' . shellescape(expand('<cfile>'), 1)<cr><cr>",
  { silent = true }
)

-- Jump history navigation
set("n", "<c-k>", "<C-o>", { desc = "back" })
set("n", "<c-j>", "<C-i>", { desc = "forward" })

-- Quit and save all
set("n", "<leader>qq", "<cmd>wqall<cr>", { silent = true, desc = "quit all" })
set("n", "<c-q>", "<cmd>wqall<cr>", { silent = true, desc = "quit all" })

-- Open current line in GitHub
set("n", "<leader>go", function()
  local file = vim.fn.expand("%:p")
  local line = vim.fn.line(".")
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local relative_path = file:sub(#git_root + 2)
  vim.fn.system(string.format("gh browse %s:%d", relative_path, line))
end, { silent = true, desc = "open in github" })

set("v", "<leader>go", function()
  local file = vim.fn.expand("%:p")
  local line_start = vim.fn.line("v")
  local line_end = vim.fn.line(".")
  if line_start > line_end then
    line_start, line_end = line_end, line_start
  end
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  local relative_path = file:sub(#git_root + 2)
  vim.fn.system(
    string.format("gh browse %s:%d-%d", relative_path, line_start, line_end)
  )
end, { silent = true, desc = "open in github" })

-- ============================================================================
-- SECTION 5: AUTOCOMMANDS
-- ============================================================================

vim.api.nvim_create_augroup("my_autocommands", { clear = true })

-- Highlight yanked text briefly
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "my_autocommands",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ timeout = 75 })
  end,
})

-- Remove trailing whitespace on save (except markdown)
vim.api.nvim_create_autocmd("BufWritePre", {
  group = "my_autocommands",
  pattern = "*",
  callback = function()
    local filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if filetype == "markdown" then
      return false
    end

    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[:keepjumps keeppatterns %s/\s\+$//e]])
    vim.cmd([[:keepjumps keeppatterns silent! 0;/^\%(\n*.\)\@!/,$d_]])

    local num_rows = vim.api.nvim_buf_line_count(0)
    if cursor_pos[1] > num_rows then
      cursor_pos[1] = num_rows
    end
    vim.api.nvim_win_set_cursor(0, cursor_pos)
  end,
})

-- Even out splits when resizing
vim.api.nvim_create_autocmd("VimResized", {
  group = "my_autocommands",
  pattern = "*",
  command = "wincmd =",
})
