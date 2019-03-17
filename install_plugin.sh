wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd .config/nvim/plugged/YouCompleteMe/
python install.py --clangd-completer