PREFIX=${1:-`pwd`/opt}
BASE="http://data.moevis.cc/"
PATH=$PREFIX/go/bin:$HOME/go/bin:$PREFIX/bin:$PATH

mkdir -p $PREFIX/go $HOME/go

function download {
    if ! [ -f $1 ]; then
        wget $BASE/$1 -O $1
    fi
    if [ $? -eq 0 ]; then
        gzip -t $1 && tar xvzf $1 -C $2 --strip 1 || tar xvf $1 -C $2 --strip 1
    else
        echo "Failed to download $BASE/$1"
    fi
}

function exists {
    command -v "$1" >/dev/null 2>&1
}

echo "export PATH=$PREFIX/bin:\$PATH" > bashrc
echo "export GOPROXY=https://goproxy.io" >> bashrc
echo "export EDITOR=nvim" >> bashrc

if ! exists go; then
    download go1.13.1.linux-amd64.tar.gz $PREFIX/go
fi

echo "export PATH=$PREFIX/go/bin:$HOME/go/bin:\$PATH" >> bashrc
echo "export GOPATH=$HOME/go" >> bashrc
echo "alias tmux='tmux -2 -L moevis -f ~/.tmux.moevis.conf'" >> bashrc

if ! exists node; then
    download node-v12.6.0-linux-x64.tar.xz $PREFIX
fi

if ! exists yarn; then
    download yarn-v1.16.0.tar.gz $PREFIX
fi

if ! exists nvim; then
    download nvim-linux64.tar.gz $PREFIX
fi

if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    wget https://raw.githubusercontent.com/moevis/dotfiles/master/.tmux-2.9.conf -O ~/.tmux.moevis.conf
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    tmux source ~/.tmux.moevis.conf
fi

if ! [ -f "$HOME/.config/nvim/init.vim" ]; then
    curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/moevis/dotfiles/master/.nvimrc
fi
