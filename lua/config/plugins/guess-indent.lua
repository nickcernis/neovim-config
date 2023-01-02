return {
  -- Automatically infer indent level.
  {
    "nmac427/guess-indent.nvim",
    config = function()
      require("guess-indent").setup({})
    end,
  },
}
