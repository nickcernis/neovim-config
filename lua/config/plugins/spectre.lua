return {
  -- Interactive find and replace within files or the whole project.
  -- https://github.com/windwp/nvim-spectre
  "windwp/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local spectre = require("spectre")
    vim.keymap.set(
      "n",
      "<a-g>",
      spectre.open,
      { silent = true, noremap = true }
    )
    vim.keymap.set(
      "n",
      "<a-f>",
      spectre.open_file_search,
      { silent = true, noremap = true }
    )
    -- "search for current word
    -- nnoremap <leader>sw <cmd>lua require('spectre').open_visual({select_word=true})<CR>
    -- vnoremap <leader>s <esc>:lua require('spectre').open_visual()<CR>
  end,
}
