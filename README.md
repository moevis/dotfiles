# My Dotfiles

## nvim

![vim](vimrc.png)

### Features

- Comfortable color.
- Linters and completions supported.
- Quick comments.
- Code Snipts.
- Highlight same id.

### Installation

Just one command:

```shell
curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/moevis/dotfiles/master/.nvimrc
```

The plugin manager `vim-plug` will be installed when nvim start. To Install the theme and plugins, open a nvim window and type:
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
- `vim-dirdiff`: Diff files and folders.
- `vim-illuminate`: hightlight same keyword.
- `asyncrun.vim`: press `F5` to run make command in async mode.
- `vim-go`
- `vim-autoformat`: Press `<leader>ff` to format your code.
- `YouCompleteMe`
- `echodoc`: Displays function signatures from completions in the command line.
- `peekaboo`: View contents of registers.
- `vim-gutentags`: ctags alternative.
- `vim-signify`: show file diff marks, press `<leader>d` to toggle line highlighting.
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
- `]q`: cprev
- `[q`: cnext
- `[a`: ALEPrevious
- `]a`: ALENext
- `[c`: previous diff
- `]c`: next diff
- `ctrl+left/right`: Switch tab
- `mt`: Move current window into next tab
- `mT`: Move current window into previous tab
- `ctrl+h/j/k/l`: switch window

EasyMotion:
 - `<leader>t`: Search char
 - `<leader>w`: Search word
 - `<space>`: Quick find

YouCompleteMe:
 - `<f11>`: Fixit
 - `<f12>`: GoTo

gtags(c++ only):
 - `<leader>cs`: Find this symbol
 - `<leader>cg`: Find this definition
 - `<leader>cd`: Find functions called by this function
 - `<leader>cc`: Find functions calling this function
 - `<leader>ca`: Find places where this symbol is assigned a value

Others:
 - `<leader>`l: Toggle line number
 - `<leader>`d: Toggle signify highlight
 - `<f10>`: toggle quickfix window

**Important**: press `<leader><tab>` to search for short cuts
