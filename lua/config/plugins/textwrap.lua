return {
  -- Set line wrapping based on filetype.
  -- Markdown is soft-wrapped, and up and down move line-wise over soft wraps.
  --
  -- https://github.com/andrewferrier/wrapping.nvim
  "andrewferrier/wrapping.nvim",
  config = function()
    require("wrapping").setup({
      -- See https://github.com/andrewferrier/wrapping.nvim#if-heuristics-make-the-wrong-choice
      softener = { markdown = true },
    })
  end,
}
