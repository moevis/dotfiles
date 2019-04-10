# download nvim binary
wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux64.tar.gz
# save to /usr/bin
tar -xvzf nvim-linux64.tar.gz --strip 1 -C /usr

# download vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
