# Neovim config

My Neovim config, one file under 1000 lines.

## Setup

Assumes macOS and Neovim 0.11+.

```sh
brew install neovim ripgrep fzf bat git-delta gnu-sed fd rg lazygit
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
bat cache --build # also re-run this if you see caching issues after bat upgrades
bat --list-themes | grep tokyo # should output "tokyonight_night"
echo '--theme="tokyonight_night"' > "$(bat --config-dir)/config"
```

## Bindings

### Search, nav, file switching

- `<space> f p` to find files in current project.
- `<space> f f` to find lines in current file (similar to swiper in Emacs).
- `<space> f g` to search text in current project (backed by ripgrep).
- `<space><tab>` for last buffer. (Repeat to alternate between two files.)
- `<space> f b` or `<space> f t` for buffer/'tab' list, then Ctrl-x to close
  buffer.
- `<space> f y` for LSP symbols list.
- `<space> f s` for git status, left to stage, right to unstage.
- `<space> f c` for recent changes.
- `<space> f j` for recent jumps.
- `<space> f r` for recent file browser.
- `<space> f <space>` for last fuzzy search with entered text retained.
- `<space> j` to jump by typed word.
- `s` for flash jump by character (letter targets after first typed character).
- `S` for flash jump based on treesitter.
- `ds` or `dS` to delete until typed character.
- `<space> r` to find-replace across project (uses Grug Find and Replace).
- `<space> f u` for undo tree, enter to revert to selected change.

### File handling

- `<space> e` to toggle the file tree ('explore'). (Then `a` to create, `r` to
  rename, `d` to delete, `?` for help, `<space> e` to close.)
- `Ctrl-h` to go back in jump list (also reopens closed buffers).
- `Ctrl-l` to go forward, :FzfLua jumps for a visual view.

### Close, quit

- `Ctrl-w` to close the buffer.
- `Ctrl-q` to save all and quit.

### Window manipulation

I use these in normal mode in place of the default Ctrl-w window commands, since
I map Ctrl-w to close buffer:

- `<space> w v` to split vertically.
- `<space> w s` to split horizontally.
- `<space> w h` to move cursor left.
- `<space> w l` to move cursor right.
- `<space> w r` to rotate buffers between window.
- `<space> w d|x` to close the window.
- `<space> b d|x` to close the buffer.

### Git

- `<space> g c` for commit list.
- `<space> g b` for branches, type new branch name and control-a to create from current.
- `<space> g s` for status (uncommitted files).
- `<space> g h` for hunks (good to navigate to recently changed location).
- `<space> g o` to open current line or range in GitHub in your browser.
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
- `Ctrl-;` to format the current buffer or selection. (Formatters configured in
'conform' block in init.lua.) 

## Commands

- `:Lazy` to update/install plugins.
- `:FzfLua` for all FzfLua pickers.
- `:Mason` to manage LSP servers.
- `:LspInfo` is sometimes useful, as is `:LspInstall`.

## Plugins

Managed with [Lazy](https://github.com/folke/lazy.nvim), which gives us a
lockfile, automatic caching and bytecode compilation, and a UI with load times.

`:Lazy` summons the plugin UI.

## Wishlist

Things to explore:

- Format pasted code when it's pasted.
  https://github.com/ConradIrwin/vim-bracketed-paste
- https://github.com/wfxr/forgit with https://github.com/ray-x/forgit.nvim.
- Disable or adjust swap file handling? https://neovim.io/doc/user/recover.html 

## Other notes

### Terminal

I use panes or tabs instead of Neovim's terminal emulation. Long-running
terminal processes in Neovim itself reduce editor performance for me. (If I open
a [toggleterm](https://github.com/akinsho/toggleterm.nvim), then run `yes` and
toggle the terminal closed, Neovim movements and edits lag for me.)

### Git

I use git and [GitHub CLI](https://cli.github.com/) in the terminal, as well as
[lazygit](https://github.com/jesseduffield/lazygit) in a separate long-running
terminal tab.

### Inspiration and reference

- Plugin ideas: https://neovimcraft.com/
- More plugin ideas: https://github.com/rockerBOO/awesome-neovim
- The semi-official starter config: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
- Opinionated starter distribution using custom plugins: https://nvchad.com/Features
- Less opinionated starter distributions using off-the-shelf plugins: https://astronvim.github.io/ and https://www.lunarvim.org/
