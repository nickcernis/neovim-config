# Neovim config

My personal Neovim config, Lua-only, from scratch where "scratch" means a bunch of plugins supplemented with personal quirks.

## Setup

Assumes macOS and Neovim 0.9+.

```sh
brew tap homebrew/cask-fonts
brew install neovim ripgrep fzf bat git-delta gnu-sed fd rg lazygit
```

You'll also need node, golang, zig and zstd to auto-install language servers (zstd is used to compress the Zig language server):

```sh
brew install node golang zig zstd
```

Then:

```sh
mkdir ~/.config && cd ~/.config
git clone https://github.com/nickcernis/neovim-config nvim
```

Optionally set the theme for bat to match Neovim, so that preview colours match:

```sh
mkdir -p "$(bat --config-dir)/themes"
cd "$(bat --config-dir)/themes"
curl -O https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/sublime/tokyonight_night.tmTheme
bat cache --build
bat --list-themes | grep tokyo # should output "tokyonight_night"
echo '--theme="tokyonight_night"' > "$(bat --config-dir)/config"
```

## Layout

```
├── README.md                 -> You are here.
├── init.lua                  -> ASCII art and includes.
├── lazy-lock.json            -> Plugin lockfile updated by Lazy.
├── local-plugins/            -> Personal plugins not yet released publicly.
└── lua
    └── config
        ├── autocommands.lua  -> Auto-strip whitespace, file picker on load.
        ├── keymaps.lua       -> Do things when you press things.
        ├── lazy.lua          -> Bootstrap the Lazy plugin manager.
        ├── options.lua       -> General settings.
        └── plugins           -> Plugin configs, loaded automatically by Lazy.
            ├── [plugin1].lua
            ├── [plugin2].lua
            └── [...].lua
```

## Bindings

### General

- `<space> f p` to find files in current project.
- `<space> f f` to find lines in current file (similar to swiper in Emacs).
- `<space> f g` to search text in current project (backed by ripgrep).
- `<space> e` to toggle the file tree. (Then `a` to create, `e`|`r`|`Ctrl-r` to edit, `d` to delete, `?` for help, `Ctrl-e` to close.)
- `<space> m` for mini file browser: create, edit, or move files by editing the nav buffer then press = in normal mode to commit changes. Browse with hjkl.
- `<space> f j` for the project switcher.
- `<space> f b` for buffer list, then Ctrl-x to close buffer.
- `<space> f y` for LSP symbols list.
- `<space> f s` for git status, left to stage, right to unstage.
- `<space> j` for word jump targets.
- `<space> t` for tab jump targets.
- `Ctrl-h` to go back in jump list (also reopens closed buffers).
- `Ctrl-l` to go forward, :FzfLua jumps for a visual view.
- `Ctrl-w` to close the buffer.
- `Ctrl-q` to save all and quit.
- `Ctrl-r` to find-replace across project (uses Grug Find and Replace).
- `Alt-h`|`Alt-l`|`Alt-[number]` to navigate tabs. Important to set the left option key to Esc+ in iTerm's key prefs (profile settings) for Alt bindings to work on macOS.

### Other bindings

I use these in normal mode in place of the default Ctrl-w window commands, since I map Ctrl-w to close buffer:

- `<space> w v` to split vertically.
- `<space> w s` to split horizontally.
- `<space> w h` to move cursor left.
- `<space> w l` to move cursor right.
- `<space> w r` to rotate buffers between window.
- `<space> w d|x` to close the window.
- `<space> b d|x` to close the buffer.

### Additional leader key bindings

- `<space> g h` to display a GitHub CLI UI.
- `<space> h p` to preview a git hunk.
- `<space> h r` to reset a git hunk.
- `<space> h R` to reset the current buffer.
- `<space> h s` to stage the hunk. 
- `<space> h S` to stage the buffer. 

### LSP

- `K` to show LSP hints.
- `gl` to show LSP issues.
- `gd` to go to definition and Ctrl-o to return.
- `gr` to show references and :q to exit.
- `F2` to rename current cursor position.
- `F4` for code actions on the current cursor position.
- `Ctrl-;` to format the current buffer or selection if the LSP server provides formatting support.

## Commands

- `:Lazy` to update/install plugins.
- `:FzfLua` for all FzfLua pickers.
- `:Mason` to manage LSP servers.
- `:LspInfo` is sometimes useful, as is `:LspInstall`.

## Plugins

Managed with [Lazy](https://github.com/folke/lazy.nvim), which gives us a lockfile, automatic caching and bytecode compilation, a smart upgrade/install UI with load time reports, and easy plugin config split across files.

Configs in `./lua/config/plugins/` are automatically loaded.

`:Lazy` summons the plugin UI.

## Wishlist

Things to explore:

### Git

- https://github.com/wfxr/forgit with https://github.com/ray-x/forgit.nvim.

### Formatting

- Format pasted code when it's pasted. https://github.com/ConradIrwin/vim-bracketed-paste

### Misc

- Hex editor backed by xxd: https://github.com/RaafatTurki/hex.nvim
- Disable or adjust swap file handling? https://neovim.io/doc/user/recover.html
- Check how file handling works if open buffers are deleted outside of nvim, such as when when switching git branch.
- Explore writing modes, perhaps https://github.com/Pocco81/true-zen.nvim or https://github.com/folke/zen-mode.nvim.
- Look at neural and similar? https://github.com/dense-analysis/neural or https://github.com/zbirenbaum/copilot.lua or https://github.com/Bryley/neoai.nvim
- Task runner for cargo run etc. with jump-to-line for compiler errors, via quickfix lists or other.
- Play with replacer: https://github.com/gabrielpoca/replacer.nvim
- Try tabout: https://github.com/abecodes/tabout.nvim
- Crates and package.json version number helpers: https://github.com/Saecki/crates.nvim
- Explore https://github.com/roobert/search-replace.nvim.

## Other notes

### Terminal

I use panes or tabs instead of Neovim's terminal emulation. Long-running terminal processes in Neovim itself reduce editor performance for me. (If I open a [toggleterm](https://github.com/akinsho/toggleterm.nvim), then run `yes` and toggle the terminal closed, Neovim movements and edits lag for me.)

### Git

I use git and [GitHub CLI](https://cli.github.com/) in the terminal, as well as [lazygit](https://github.com/jesseduffield/lazygit) in a separate long-running terminal tab.

### Inspiration and reference

- Plugin ideas: https://neovimcraft.com/
- More plugin ideas: https://github.com/rockerBOO/awesome-neovim
- New stuff every week: https://this-week-in-neovim.org/
- The semi-official starter config. A little scrappy but worth reading: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
- Opinionated starter distribution using custom plugins: https://nvchad.com/Features
- Less opinionated starter distributions using off-the-shelf plugins: https://astronvim.github.io/ and https://www.lunarvim.org/
- An overview of Neovim's LSP configuration spaghetti: https://roobert.github.io/2022/12/03/Extending-Neovim/
