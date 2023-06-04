-- Debug Adapter Protocol (DAP) support.
-- Provides step-through debugging with a UI and bindings.
--
-- Default debug adapters to install are set in lsp.lua to ensure that
-- logic there runs after Mason is initialized..
--
return {
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
      require("dapui").setup()
      require("nvim-dap-virtual-text").setup()

      -- Automatically show/hide DAP UI when the debug adapter starts/stops.
      local dap = require("dap")
      local dapui = require("dapui")
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- TODO: fix UI issue when showing and hiding filetree.
      vim.keymap.set(
        "n",
        "<leader>du",
        '<cmd>lua require("dapui").toggle()<CR>',
        { desc = "dap toggle ui", silent = true, noremap = true }
      )

      vim.keymap.set(
        "n",
        "<leader>ds",
        '<cmd>lua require"dap".continue()<CR>',
        { desc = "dap start/continue", silent = true, noremap = true }
      )

      vim.keymap.set(
        "n",
        "<leader>db",
        '<cmd>lua require"dap".toggle_breakpoint()<CR>',
        { desc = "dap toggle breakpoint", silent = true, noremap = true }
      )

      vim.keymap.set(
        "n",
        "<leader>do",
        '<cmd>lua require"dap".step_over()<CR>',
        { desc = "dap step over", silent = true, noremap = true }
      )

      vim.keymap.set(
        "n",
        "<leader>di",
        '<cmd>lua require"dap".step_into()<CR>',
        { desc = "dap step into", silent = true, noremap = true }
      )

      vim.keymap.set(
        "n",
        "<leader>dt",
        '<cmd>lua require"dap".step_out()<CR>',
        { desc = "dap step out", silent = true, noremap = true }
      )

      vim.keymap.set(
        "n",
        "<leader>dx",
        '<cmd>lua require("dapui").disconnect()<CR>',
        { desc = "dap disconnect", silent = true, noremap = true }
      )
    end,
  },
}
