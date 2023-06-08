return {
  -- Saves buffers when leaving insert mode.
  -- https://github.com/Pocco81/auto-save.nvim
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        -- Removed TextChanged default event to prevent whitespace clearing
        -- when pressing enter in a block, due to autocommand that strips
        -- white space on save.
        trigger_events = { "InsertLeave" },
        execution_message = {
          -- Message to print on save.
          message = function()
            return ("💾 " .. vim.fn.strftime("%H:%M:%S"))
          end,
        },
      })
    end,
  },
}
