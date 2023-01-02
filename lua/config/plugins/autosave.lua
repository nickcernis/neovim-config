return {
  -- Saves buffers when leaving insert mode.
  -- https://github.com/Pocco81/auto-save.nvim
  {
    "Pocco81/auto-save.nvim",
    config = function()
      require("auto-save").setup({
        -- trigger_events = {"InsertLeave", "TextChanged"}, -- defaults, see :h actions to extend.
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
