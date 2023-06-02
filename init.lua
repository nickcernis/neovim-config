--  __________________________________
-- < OOoo, it’s Nick’s Neovim config. >
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

require("config.options") -- General settings.
require("config.lazy") -- Plugin setup using lazy.nvim.
require("config.autocommands") -- Auto-trim whitespace, open find_files on startup and more.
require("config.keymaps") -- Do things when I press things.

-- That's it. See ./README.md and ./lua/config/ for more.
