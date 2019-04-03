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

For vim users:
```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Setup your `.vimrc`:
```
wget https://raw.githubusercontent.com/moevis/dotfiles/master/.nvimrc -O ~/.vimrc
```

Open a vim window and type:
```
:PlugInstall
```

**One more step for YouCompleteMe**:
If you write C/C++ and wanna code completion for c-family languages. You should go to `~/.config/nvim/plugged/YouCompleteMe/`(Neovim) and run `python3 install.py --clang-completer`. Or go to `.vim/plugged/YouCompleteMe` and run `python3 install.py --clang-completer`.
download `https://raw.githubusercontent.com/moevis/dotfiles/master/.ycm_extra_conf.py` and save to `~/.vim/.ycm_extra_conf.py`.

Feel free to edit it to fit into your project, you can have a local copy at the root of your project directory.
