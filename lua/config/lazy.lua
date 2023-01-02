-- Manage plugins with Lazy.
-- https://github.com/folke/lazy.nvim
--
-- Plugin config lives in lua/config/plugins/. Run :Lazy for plugin TUI to
-- update plugins. Load this file in init.lua with require('config.lazy'),
-- after the leader key is mapped.

-- Bootstrap lazy.
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

-- Loads everything in lua/config/plugins.
-- See https://github.com/folke/lazy.nvim#-structuring-your-plugins.
require("lazy").setup("config.plugins", {
  change_detection = {
    notify = false, -- Suppress change notices (default true results in having to dismiss the notice every time you change plugin config).
  },
})
