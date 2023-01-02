return {
  -- Adds text objects such as vii.
  {
    "chrisgrieser/nvim-various-textobjs",
    config = function()
      require("various-textobjs").setup({ useDefaultKeymaps = true })
    end,
  },
}
