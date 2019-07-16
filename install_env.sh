PREFIX=${1:-`pwd`/opt}
BASE="http://data.moevis.cc/"
PATH=$PREFIX/usr/go/bin:$PREFIX/go/bin:$PREFIX/bin:$PATH

mkdir -p $PREFIX/usr/go

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

if ! exists go; then
    download go1.12.6.linux-amd64.tar.gz $PREFIX/usr/go
fi

echo "export PATH=$PREFIX/usr/go/bin:$PREFIX/go/bin:\$PATH" >> bashrc
echo "export GOPATH=$PREFIX/go" >> bashrc

if ! exists node; then
    download node-v12.6.0-linux-x64.tar.xz $PREFIX
fi

if ! exists yarn; then
    download yarn-v1.16.0.tar.gz $PREFIX
fi

if ! exists nvim; then
    download nvim-linux64.tar.gz $PREFIX
fi

if ! exists gopls; then
    mkdir -p $PREFIX/go/src/github.com
    mkdir -p $PREFIX/go/src/golang.org
    mkdir -p $PREFIX/go/bin
    
    download go-github.com.tar.gz $PREFIX/go/src/github.com
    download go-golang.org.tar.gz $PREFIX/go/src/golang.org
    download go-bin.tar.gz $PREFIX/go/bin
fi

if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    wget https://raw.githubusercontent.com/moevis/dotfiles/master/.tmux-2.9.conf -O ~/.tmux.conf
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    tmux source ~/.tmux.conf
fi

if ! [ -f "$HOME/.config/nvim/init.vim" ]; then
    curl -fLo ~/.config/nvim/init.vim --create-dirs https://raw.githubusercontent.com/moevis/dotfiles/master/.nvimrc
fi
