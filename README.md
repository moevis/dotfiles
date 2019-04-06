# My Dotfiles

## vim/nvim

![vim](vimrc.png)

### Installation

Please install `vim-plug` first.

For neovim users:
```shell
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Create a new folder and save the nvimrc:
```
mkdir -p ~/.config/nvim
wget https://raw.githubusercontent.com/moevis/dotfiles/master/.nvimrc -O ~/.config/nvim/init.vim
```

Open a nvim window and type:
```shell
:PlugInstall
```

**One more step for YouCompleteMe**

If you write C/C++ and wanna code completion for c-family languages. You should go to `~/.config/nvim/plugged/YouCompleteMe/`(Neovim) and run `python3 install.py --clang-completer`. When nvim started, a configure file `.ycm_extra_conf.py` will be downloaded and save to `~/.config/nvim/.ycm_extra_conf.py`.

Feel free to edit it to fit into your project, you can have a local copy at the root of your project directory.

### Plugin overview

Leader key is mapped to `,`.

- `vim-surround`
- `vim-headerguard`: Use `:HeaderguardAdd` to insert a headerguard for your c++ header file, the default naming rule is defined in `.vimrc` or `init.vim` as below:
```
function! g:HeaderguardName()
  return "PROJECT_" . toupper(expand('%:gs/[^0-9a-zA-Z_]/_/g'))
endfunction
```

- `vim-expand-region`: Use `+` to expand your selection.
- `vim-shebang`: Type `:SheBangInsert python` to add shebang to your script.
- `vim-commentary`: Quick comment/uncomment code by typing `gcc`.
- `tabular`: Plugin to align your code, mapping to shortcuts like `<leader>a=`, `<leader>a:`, `<leader>a,` .
- `nerdtree`: Type `<leader>nn` to toggle siderbar.
- `nerdtree-git-pugin`: Add file status icon according git status in nerdtree.
- `comfortable-motion`: Use `ctrl+d` and `ctrl+u` to scroll screen smoothly.
- `auto-pairs`
- `ale`: Powerful syntax checking tool.
- `lightline`
- `vim-easymotion`: Type `<leader>t` to jump to char and `<leader>w` to jump to word.
- `fzf`: Amazing searching tool! Press `K` to search current word under the cursor (requiring `ag`).
- `targets`: Imporving your motion key.
- `vim-go`
- `vim-autoformat`: Press `<leader>ff` to format your code.
- `YouCompleteMe`
- `peekaboo`: View contents of registers.
- `vim-gutentags`: ctags alternative.
- `LeaderF`:
  - `<f4>`: Search buffers.
  - `<f3>`: MRU Buffer.
  - `<f2>`: Search functions in the buffer.
  - `<f1>`: Search tags provided by ctags.
- `tmux-navigator`: Easily switching bwteen tmux and vim.

### Shortcuts

Copy & Paste:
- `<leader>y`: Copy to clipboard
- `<leader>p`: Paste from clipboard
- `<leader>d`: Delete content without storing it in register.

Navigate:
- `<leader>]`: cnext
- `<leader>[`: cprev
- `<leader>-`: ALEPrevious
- `<leader>=`: ALENext
- `ctrl+left/right`: Switch tab
- `mt`: Move current window into next tab
- `mT`: Move current window into previous tab

YouCompleteMe:
- `<f11>`: Fixit
- `<f12>`: GoTo

Others:
- `<leader><leader>`: V
- `<leader>`l: Toggle line number
- `<leader>`d: Toggle signify highlight

- `<f10>`: toggle quickfix window
