PREFIX=${1:-`pwd`/opt}
BASE="http://data.moevis.cc"
PATH=$PREFIX/go/bin:$HOME/go/bin:$PREFIX/bin:$PATH

mkdir -p $PREFIX/go $HOME/go $PREFIX/bin

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

# using command 'tmux2' as an alias of 'tmux -f ~/.tmux.moevis.conf'
echo "#!/bin/bash" > $PREFIX/bin/tmux2
echo "trap '' INT TSTP" >> $PREFIX/bin/tmux2
echo 'tmux -2 -L moevis -f ~/.tmux.moevis.conf "$@"' >> $PREFIX/bin/tmux2
chmod +x $PREFIX/bin/tmux2

if ! exists go; then
    download go1.18.linux-amd64.tar.gz $PREFIX/go
    rm -f go1.18.linux-amd64.tar.gz
fi

echo "export PATH=$PREFIX/go/bin:$HOME/go/bin:\$PATH" >> bashrc
echo "export GOPATH=$HOME/go" >> bashrc

if ! exists node; then
    download node-v15.6.0-linux-x64.tar.xz $PREFIX
    rm -f node-v15.6.0-linux-x64.tar.xz
fi

if ! exists yarn; then
    download yarn-v1.22.4.tar.gz $PREFIX
    rm -f yarn-v1.22.4.tar.gz
fi

if ! exists nvim; then
    download nvim-linux64.tar.gz $PREFIX
    rm -f nvim-linux64.tar.gz
fi

if ! exists rg; then
    download ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz $PREFIX
    rm -rf ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz
fi

if ! exists tmux; then
    wget -O $PREFIX/bin/tmux $BASE/tmux
    chmod +x $PREFIX/bin/tmux
fi

if ! [ -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    wget $BASE/tmux.conf -O ~/.tmux.moevis.conf
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    tmux source ~/.tmux.moevis.conf
fi

if ! [ -f "$HOME/.config/nvim/init.vim" ]; then
    curl -fLo ~/.config/nvim/init.vim --create-dirs $BASE/nvimrc
fi
