return {
  -- gcc to toggle comments
  -- https://github.com/numToStr/Comment.nvim
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
}
